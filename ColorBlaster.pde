//******************
//  COLOR BLASTER
//******************
//By Steven Schwarcz

boolean pause = false;

// Array for controller keys
boolean[] keys = new boolean[4];
final int W = 0;
final int A = 1;
final int S = 2;
final int D = 3;

//sounds
import ddf.minim.*;
Minim minim;
AudioSample sShot;       //bullets bullet fire
AudioSample lShot;       //large shot fire
AudioSample boom;        //enemy explosion

//import procontroll


boolean playing = false;
boolean instructions = false;

Land [][] ground;                           //Declare ground array

//declare fonts and font color
PFont font0;
PFont font1;
PFont font2;
color fColor;

//text variables
int noticeTimer = 0;                //remaining frames to display powerup informaiton
boolean noticeFlash = false;        //true = powerup text is displaying
String noticeText;                  //any notice that the game must show the player

//basic game variables
int livingE;                    //Number of living enemies (enemy counter)
int livingB;                    //number of living bosses
int maxB;                       //maximum number of bosses
int cCode = 8;                  //Color code.  Determines the colors of objects
int oCode;                      //objective color code
int lives;                      //number of lives player has
int nukes;                      //number of nukes a player has
int pRespawn;                   //time until respawn of player
boolean alive;                  //whether or not player is alive

//bullets and explosions
Bullet [] bullets = new Bullet [100];       //bullets
Explosion [] nuke = new Explosion [3];      //nuke
Explosion death = new Explosion (8);        //explosion on player death
Implosion newLife = new Implosion (8);      //implosion to signal respawning of player

//balance variables - starting
float mod;                //speed modifier
int multiplier;           //score mulitplier
int respawnRate;          //respawn rate of enemies

//balance variables - pacing
float stdMod;             //standard speed at which speed increases
float scMod;              //speed increase when multiplier is increased
float maxMod;             //maximum speed modifier
float timeMod;            //modifies game speed
int minSpawn;             //minimum spawn rate
int consecSpawn;          //highest number of enemies that can spawn in a single frame

//scoring variables
int score;                //score
int hsE;                  //high score easy
int hsM;                  //high score medium
int hsH;                  //high score hard
float gameLength;         //game length

//aiming variables
PVector aim = new PVector (mouseX, mouseY);      //aiming vector
float aAngle;                                    //aim angle
float aimS;                                      //aim sensativity
int reticle;                                     //reticle distance from ship
int reload = 0;                                  //count down until able to shoot again

//difficulty variables
//Button dButton = new Button ("EASY", "NORMAL", "HARD");    //button to control difficulty
final int EASY = 0;
final int MEDIUM = 1;
final int HARD = 2;
int difficulty = EASY;

PVector player = new PVector(width/2,height/2);   //location of ship
PVector pPlayer = player.get();                         //previous location of ship
PVector pVelocity = new PVector(0,0);                      //velocity of ship

//*****************
//     SETUP
//*****************
void setup()
{
  //sound
  minim = new Minim (this);
  sShot = minim.loadSample ("L_Shot.mp3", 512);       //sound for bullets shot
  lShot = minim.loadSample ("S_Shot.mp3", 512);       //sound for large shot 
  boom = minim.loadSample ("Boom0.mp3", 512);         //hit enemy
  
  size (750,750);
  smooth();
  frameRate(45);
  noCursor();

  //initialize font
  font0 = loadFont ("Monospaced-22.vlw");
  font1 = loadFont ("Monospaced-30.vlw");
  font2 = loadFont ("Dialog-15.vlw");
  fColor = colorize (oCode);
  textAlign(CENTER);
  
  //create ground
  ground = new Land[width / G_DEN + 1][height / G_DEN + 2];
  
  //fill ground array  
  for(int x = 0; x < ground.length; x ++)
    for(int y = 0; y < ground[x].length; y ++)
      ground[x][y] = new Land (x * G_DEN, y * G_DEN);
      
  //fill nuke array
  for (int i = 0; i < nuke.length; i++)
    {
      nuke [i] = new Explosion (8);
    }
    
 // Set all controller keys to "not pressed"
 for (int i = 0; i< 4; i++) 
 {
   keys[i] = false;
 }
 
 //initialize aim sensativity and reticle distance
 if (arrowReticle)
 {
   aimS = aAimS;
   reticle = aReticle;
  }
  else
  {
    aimS = cAimS;
    reticle = cReticle;
  }
}



//*****************
//      DRAW
//*****************
void draw()
{  
  background (0);
  
  //move ground
  grounding();
  
  //draw power up information    
  powerUpCheck();
  
  if (playing)
  {    
    //spawn enemies
    spawnE(livingE);
    
    //temp();
    
    //move bullets and check if they hit
    for (int i = 0; i < bullets.length; i++)
    {
      bullets[i].move();
      for (int j = 0; j < enemies.length; j++)
      {
        enemies[j].hit(bullets[i]);
      }
    }
    
    //check if player should be respawning
    if (! alive)
      checkAlive();
    
    //move player
    if (alive)
      ship();
    
    //dictate enemy behavior
    for (int i = 0; i < enemies.length; i++)
    {
      enemies[i].behave();
    }
    
    //show reticle and allow for aiming
    if (alive)
      reticle();
    
    //check for nuke
    for (int i = 0; i < nuke.length; i++)
    {
      nuke[i].check(width / 2, height / 2);
      
      //reset nuke
      if (! nuke [2].getHappening())
        nuke[i] = new Explosion (8);
    }
    
    //don't let score fall below zero (done here so that there won't be a frame where the score is shown as negative)
    if (score < 0)
      score = 0;

    
    
    
    //*****************
    //  FIRE BULLETS
    //*****************
    
    if (mousePressed && alive)
    {
      if(mouseButton == RIGHT)
      {
        for (int i = 0; i < bullets.length; i++)
        {
          if (! bullets[i].firing && reload <= 0)           //check if bullet is already firing
          {
            bullets[i].fire (player.x, player.y, oCode, LARGE, 0);    //fire shot
            reload = LARGE_FR;                              //set reload
          
            //trigger sound
            lShot.trigger();
            
            //end loop
            i = bullets.length;
          }
        }
      }
      
      if (mouseButton == LEFT)
      {
        for (int i = 0; i < bullets.length; i++)
        {
          if (! bullets[i].firing && reload <= 0)
          {
            //determine what kind of bullet to shoot based on power ups
            if (! spread && ! laser)
              bullets[i].fire (player.x, player.y, oCode, SMALL, 0);      //fire shot

            //spread
            else if (spread)
            {
              bullets[i].fire (player.x, player.y, oCode, SPREAD, 0);
              
              //add extra shots for spread
              for (int j = 0; j < bullets.length; j++)
              {
                if (! bullets[j].firing && reload <= 0)
                {
                  bullets[j].fire (player.x, player.y, oCode, SPREAD, PI / SHOT_SPREAD);
                  j = bullets.length;
                }
              }
              
              //add extra shots for spread
              for (int j = 0; j < bullets.length; j++)
              {
                if (! bullets[j].firing && reload <= 0)
                {
                  bullets[j].fire (player.x, player.y, oCode, SPREAD, - PI / SHOT_SPREAD);
                  j = bullets.length;
                }
              }
            }
            
            //laser
            else if (laser)
            {
              bullets[i].fire (player.x, player.y, oCode, LASER, 0);
            }
            
            reload = SMALL_FR;                                //set reload
            
            //trigger sound
            sShot.trigger ();
            
            //end loop
            i = bullets.length;
          }
        }
      }
    }
    
    
    
    
    
    //*****************
    //   HIT PLAYER
    //*****************
    for (int i = 0; i < enemies.length; i ++)
    {
      if (enemies[i].hit(player))
      {
        if (! shield)         //ensure the shield is not up
          playerHit();
        
        //reduce powerup timer if shield is active
        else
        {
          enemies[i].explode();
          powerUpTime -= 100;
        }
      }
    }
    
    //check for any explosions
    death.check(player.x, player.y);
    newLife.check(player.x, player.y);
    
        
    
    
    
    
    //*****************
    //    GAME TEXT
    //*****************
    
    //display high score
    textFont(font0);
    textAlign (LEFT);
    fill(255);
    
    if (difficulty == EASY)
      text ("High Score: " + hsE + " (easy)", 10, 30);
    else if (difficulty == MEDIUM)
      text ("High Score: " + hsM + " (normal)", 10, 30);
    else if (difficulty == HARD)
      text ("High Score: " + hsH + " (hard)", 10, 30);
    
    //font color
    if (oCode <= 7)
      fColor = colorizeF (oCode);
    else if (oCode == 8)
      fColor = color(255);
    if (oCode == 3)
      fColor = color(0,200,255);
    
    //display score
    fill (fColor);
    textAlign(LEFT);
    text ("Score: " + score, width - 220, height - 40);
    text ("Multiplier: X " + multiplier, width - 220, height - 20);
    
    if(LIVES > 1)
    {
      //fill(255);
      text("Lives: " + lives, 20, height - 40);
    }
    
    text("Nukes: " + nukes, 20, height - 20);
    
    //resets text
    textAlign (CENTER, CENTER);
    fill(255);
    
    //displays any notice information every (flash) frames
    if (noticeTimer > 0)
    {
      if (noticeFlash)
        text (noticeText, width / 2, height / 2 + 60);
      
      if (noticeTimer % NOTICE_FLASH == 0)
      {
        if (noticeFlash)
          noticeFlash = false;
        else
          noticeFlash = true;
      }
      
      //decrease notice timer  
      noticeTimer --;
    }
    
    
    
    
    
    
    
    //*****************
    //     OTHER
    //*****************    
    
    //determines number of enemies alive
    int livingE = 0 + livingB * B_COUNT;
    
    for (int i = 0; i < enemies.length; i++)
    {
      if (enemies[i].getAlive())
        livingE ++;
    }
    
    reload --;                                          //reduce number of frames until next shot
    
    //get player velocity
    pVelocity = player.get();
    pVelocity.sub(pPlayer);
    
    pPlayer = player.get();                             //replace the previous player location with this one
    gameLength += timeMod;                              //add to the number of frames the game has been played
    pRespawn --;                                        //reduce time until player respawns
    
    //don't let modifer surpass MAX_MOD
    if(mod > maxMod)
      mod = maxMod;
    
    //high score update
    if (score > hsE && difficulty == EASY)
      hsE = score;
    else if (score > hsM && difficulty == MEDIUM)
      hsM = score;
    else if (score > hsH && difficulty == HARD)
      hsH = score;
    
    //code to see important variables
    //println ("FPS:" + (int)frameRate + " enemies on screen: " + livingE + " Score: " + score + " respawn: " + respawnRate + " mod: " + mod);
    //println("stdMod: " + stdMod + " scMod: " + scMod + " maxMod: " + maxMod + " timeMod: " + timeMod + " minSpawn: " + minSpawn + " consecSpawn: " + consecSpawn); 
  }
  
  
  

  //*****************
  //  NON-GAME TEXT
  //*****************  
  
  //instructions
  if (instructions)
    instructions();
  
  //show cursor
  if (! playing)
  {
    fill(255);
    noStroke ();
    ellipse(mouseX, mouseY, 8,8);
  }
  
  //GAME OVER
  if (! playing && ! instructions)
  {
    gameOverText();
  }
}

void stop()
{
  sShot.close();
  lShot.close();
  boom.close();
  minim.stop();
  super.stop();
}
