//*****************
// ENEMY SPAWNING
//*****************
int spawning;          //random integer determining what spawns
int numSpawn;          //number of enemies to spawn at a single time

void spawnE(int livingE)
{
  //checks: 1. if player is alive, 2. if it is time to respawn, 3. if there is a nuke exploding
  if (alive && livingE < MAX_E && frameCount % respawnRate == 0 && ! nuke [1].getHappening())
  {
    //increase modifier (this is done here so that the effect happens only when an enemy would spawns
    mod += stdMod;                  //increase speed
    
    //determine how many enemies will spawn this frame
    numSpawn = int(random(1, consecSpawn + 1));
    
    for (int i = 0; i < enemies.length; i++)
    {
      if (! enemies[i].getAlive() && ! enemies[i].getExplosion() && enemies[i].getWarning() <= 0)        //find a dead enemy and replace with a living one
      {
        numSpawn --;
        
        while (! enemies[i].getAlive() && ! enemies[i].getExplosion() && enemies[i].getWarning() <= 0)
        {
          spawning = int(random(0,36));          //random integer determining what spawns
          //spawning = 35;
            
          if (spawnCondition(0, 6, 0))
            enemies[i] = new Missile (random (3.5,4.5), random(20, 30), rand(cCode), false); 
          
          else if (spawnCondition(6, 14, 0))
            enemies[i] = new Enemy (random (1.5,2.5), random(25, 35), rand(cCode), false);
          
          else if (spawnCondition(14, 19, 0))
            enemies[i] = new Enemy (random (1.5,2.5), random(25, 35), rand(cCode), true);
          
          else if (spawnCondition(19, 24, 300))
            enemies[i] = new Missile (random(3.5, 4.5), random(20, 30), rand(cCode), true);          //random(3.5, 4.5)   300        *
          
          else if (spawnCondition(24, 29, 500))
            enemies[i] = new Spiraler (.8, 25, randP(cCode));
          
          else if (spawnCondition(29, 33, 700))
            enemies[i] = new DEnemy (random (2.5,3), random(15, 25), rand(cCode), true);   //random (2.5,3.5) 700      *
          
          else if (spawnCondition(33, 1200))
            enemies[i] = new Wall (); 
          
          else if (spawnCondition(34, 1500))
            enemies[i] = new Spawner (); 
            
          else if (spawnCondition(35, 1500))
            enemies[i] = new Snake (); 
        }
        
        if (numSpawn == 0)
          i = enemies.length;
      }
    }
  }
  
  //increase number of bosses in late game
  if (gameLength % 2400 == 0 && maxB < MAX_B)
    maxB ++;
}

//determines whether spawn conditions are properly met to spawn an enemy
//spawning must be between a and b, and gameLength must be over gl
boolean spawnCondition (int a, int b, int gl)
{   
  if (spawning >= a && spawning < b && gameLength >= gl)
    return true;

  //else
  return false;
}

//determines whether spawn conditions are properly met to spawn a boss
//spawning must be equal to a, and gameLength must be over gl
boolean spawnCondition (int a, int gl)
{   
  if (spawning == a && gameLength >= gl && livingB < maxB)// && livingE < MAX_E - (livingB + 1) * B_COUNT )
    return true;

  //else
  return false;
}



//*****************
// DISPLAY GROUND
//*****************
void grounding()
{  
 for(int x = 0; x < ground.length; x ++)
 {
   for(int y = 0; y < ground[x].length; y ++)
   {
     ground[x][y].display();
   }
 }
 
 //reset to top
 for(int x = 0; x < ground.length; x ++)
   for(int y = 0; y < ground[x].length; y ++)  
     if (ground[x][y].getY() > height - (height % G_DEN))
       ground[x][y] = new Land (x * G_DEN, 0);
}





//*****************
//   PLAYER HIT
//*****************
//if player is hit
void playerHit()
{
  //trigger death explosion
  death.boom(30, 40, 3.5);                
  
  //get rid of enemies
  for (int i = 0; i < enemies.length; i++)
  {
    if (enemies[i].getAlive())
    {  
      enemies[i].explode();
      
      if (enemies[i].getWarning() > 0)
      {
        enemies[i].setWarning(1);
      }
    }
  }
  
  //reduce lives
  lives --;
  
  //kill player
  alive = false;
  
  //reset respawn timer
  pRespawn = P_RESPAWN;
  
  //reset colors of game
  cCode = int(random(1,9));
  oCode = randP(cCode);
  
  //turn off power ups
  powerUpTime = 0;
  
  //reset new life implosion color
  newLife = new Implosion(oCode);
}

//checks if player is alive
void checkAlive()
{
  for (int i = 0; i < enemies.length; i++)
    enemies[i].kill();
 
  //reset player location if coming back to life
  if(pRespawn == 0)
  {      
    //end game if out of lives
    if (lives == 0)
      gameOver();
    
    //reset location
    player = new PVector(width / 2, height / 2);
    
    //trigger new life implosion as a visual que for respawn
    newLife.boom(35, 50, 4);
  }
  
  if (pRespawn < 0 && ! newLife.getHappening())
  {
    //set alive to true
    alive = true;
  }
}

//end game processes
void gameOver()
{  
  //end game
  playing = false;
  
  //reset code
  cCode = 8;
}





//****************
//  SPECIAL HIT
//****************

//change objective and score when a large bullet hits
void specialHit(int code)
{
    cCode = code;                                //change code
    oCode = randP(cCode);                        //change code
    death = new Explosion(oCode);                //change the code of the player's death explosion
    mod += scMod;                          //increase game speed
      
    multiplier += 1;                             //increase multiplier
    
    //increase spawn rate
    if (respawnRate > minSpawn)
      respawnRate -= 1;
      
      
    //increase number of nukes if multiplier is a multiple of 5
    if (multiplier % 2 == 0 && gameLength > 0)
      powerUp();
}





//*****************
//    MENU TEXT
//*****************
void instructions()
{
  fill(255);
  textFont (font2);
  
  int y = 60;          //y location of the text.  Using a variable makes it easier to add new text later
  
  text ("Use WASD to move around and the mouse to aim.", width / 2, y);
  y += 40;
  text ("Hold the left mouse button to fire regular shots.", width / 2, y);
  y += 40;
  text ("Hold the right mouse button to fire special shots.", width / 2, y);
  y += 40;
  text ("Regular shots give you points based on the multiplier.  Special shots don't.", width / 2, y);
  y += 40;
  text ("If a special shot hits an enemy matching your ship, the multiplier will go up.", width / 2, y);
  y+= 40;
  text ("Spacebar launches a nuke and kills every enemy.", width / 2, y);
  y += 80;  
  text ("Good Luck!", width / 2, y);
}

void gameOverText()
{
  //highscore text for menu
  textFont(font0);
  textAlign (LEFT);
  fill(255);
  text ("High Score: " + hsE + " (easy)", 10, 30);
  text ("High Score: " + hsM + " (normal)", 10, 50);
  text ("High Score: " + hsH + " (hard)", 10, 70);
  
  textAlign (CENTER);
  textFont (font1);
  text ("COLOR BLASTER", width / 2, height / 2);
  textFont (font0);
  text ("Score: " + score, width / 2, (height / 2) + 20);
  text ("Press Space to Play", width / 2, (height / 2) + 80);
  text ("Press \"I\" for Instructions", width / 2, (height / 2) + 115);
  
  //display difficulty button
  //dButton.display(width / 2, height / 2 + 250, 120, 40);
  
  if (arrowReticle)
    text("Press \"R\" to Change Reticle (Current: Arrow)", width / 2, (height / 2) + 150);
  else if (! arrowReticle)
    text("Press \"R\" to Change Reticle (Current: Circle)", width / 2, (height / 2) + 150);
    
  if (difficulty == EASY)
    text("Press \"F\" to Change Difficulty (Current: Easy)", width / 2, (height / 2) + 185);
  else if (difficulty == MEDIUM)
    text("Press \"F\" to Change Difficulty (Current: Normal)", width / 2, (height / 2) + 185);
  else if (difficulty == HARD)
    text("Press \"F\" to Change Difficulty (Current: Hard)", width / 2, (height / 2) + 185);
}


//NOTE:dButton entails this, a declaration, and the display method above
/*void mousePressed()
{
  if (! playing && ! instructions)
    dButton.pressed();
}*/






//*****************
//  KEY PRESSES
//*****************

void keyPressed()
{   
  //INSTRUCTIONS
  if (key == 'i' && ! playing && ! instructions)
    instructions = true;
  else if (key == 'i' && instructions)
    instructions = false;
  
  
  //NEW GAME
  if (key == ' ' && ! playing)
  {
    reset();
  }
  
  //NUKE
  else if (key == ' ' && ! nuke[2].happening && nukes > 0 && alive && ! pause)
  {
    nukes --;
    
    for (int i = 0; i < nuke.length; i++)
    {
      nuke[i].boom((i + 1) * 15, (i + 1) * 40, (i + 6));
    }
    
    //reduce score
    //score -= 5 * multiplier + multiplier * livingE;
    //score -= multiplier * livingE;
    
    //kill everything
    for (int i = 0; i < enemies.length; i++)
    {
      enemies[i].setWarning(0);
      if (enemies[i].getAlive())
        enemies[i].explode();
    }
    
    //reset after nuke and add to speed modifier
    cCode = rand(cCode);
    oCode = randP(cCode);
    mod += .1;
  }
    
  //PAUSE
  if (key == 'p' && ! pause && playing)
  {  
    fill(255);
    textFont(font0);
    textAlign(CENTER, CENTER);
    text("PAUSED",width/2, height/2);
    noLoop();
    pause = true;
    text("Press \"T\" to return to main menu.", width / 2, height / 2 + 120);
  }
  
  else if (key == 'p' && pause)
  {
    loop();
    pause = false;
  }
  
  //RESTART
  if (key == 't' && pause)
  {
    loop();
    powerUpTime = 0;
    gameOver();
    pause = false;
  }
  
  //DIFFICULTY (0 = easy, 1 = normal, 2 = hard)
  if (key == 'f' && ! playing)
  {
    difficulty ++;
    
    if (difficulty == HARD + 1)
      difficulty = EASY;
  } 
  
  //RETICLE
  if (key == 'r')
  {    
    //set text warning
    noticeTimer = NOTICE_FLASH - 1;
    noticeFlash = true;  
    
    if (arrowReticle) 
    {
      arrowReticle = false;
      aimS = cAimS;
      reticle = cReticle;
      
      //determine what displays on screen
      noticeText = "Reticle: Circle";
    }
    else
    {
      arrowReticle = true;
      aimS = aAimS;
      reticle = aReticle;
      
      //determine what displays on screen
      noticeText = "Reticle: Arrow";
    }
  } 
  
  //MOVEMENT
  if(key == 'w') 
  {
    keys[W] = true;
  } 
  else if(key == 'a') 
  {
    keys[A] = true;
  } 
  else if(key == 's') 
  {
    keys[S] = true;
  } 
  else if (key == 'd') 
  {
    keys[D] = true;
  }
}


//END MOVEMENT
void keyReleased() 
{
 if(key == 'w') 
 {
   keys[W] = false;
 } 
 else if(key == 'a') 
 {
   keys[A] = false;
 }
 else if(key == 's') 
 {
   keys[S] = false;
 } 
 else if (key == 'd') 
 {
   keys[D] = false;
 }
} 
