//spawner boss that spawns smaller enemies and missiles
class Spawner extends Boss
{
  int MAX_S = 3;
  int sRespawnRate = 30;
  
  Enemy[] spawns = new Enemy[MAX_S];
  
  Spawner()
  {
    super(.5, 50, 9, false);
    
    hp = 45;
    value = 10;
    
    /*return size to normal (note: with spawners, the size is orignally doubled to increase the number of particles,  
    it is now reduced for the sake of hit box calculation)*/
    //eSize /= 1;
    
    //fill array of enemies
    for (int i = 0; i < spawns.length; i++)
      spawns [i] = new Enemy (random (1.5,2.5), 30, oCode, false);
    
    //kill extra enemies
    for (int i = 0; i < spawns.length; i++)
    {
      spawns[i].kill();
    }
  }
  
  //creates particle array
  void spawn()
  {    
    //fill array of particles
    for(int i = 0; i < particles.length; i++)
    {
      initParticles(i, 0, 2 * PI, 2, 4);
    }
  }
  
  //gives a text display warning
  /*void extraWarning()
  {
    fill(255);
    textAlign(CENTER, CENTER);
    text("Incoming Spawner Enemy", width / 2, height / 2);
  }*/
  
  //draw ellipses to represent remaining HP
  void extraDisplay()
  {
    for (int i = hp; i >= 0; i--)
    {
      fill(colorize(8), 40);
      ellipse(location.x, location.y, i * 1.2, i * 1.2);
    }
    
    //spawn new small enemies
    int spawning;          //random integer determining what spawns
    
    Sspawn();
  }
  
  void extraExplode()
  {
    livingB --;
    
    for (int i = 0; i < spawns.length; i++)
    {
      spawns[i].explode();
    }
  }

  //spawn smaller enemies
  void Sspawn()
  {
    if (frameCount % sRespawnRate == 0 && alive)
    {
      for (int i = 0; i < spawns.length; i++)
      {
        if (! spawns[i].getAlive() && ! spawns[i].getExplosion())        //find a dead enemy
        {
          int spawning = int(random(0,4));
          {
            if (spawning >= 0 && spawning < 3)
              spawns[i] = new Missile (random (4.5,5.5), 15, rand(cCode), true); 
            else if (spawning == 3)
              spawns[i] = new DEnemy (random (2.5,3.5), 20, rand(cCode), true); 
          }
          
          spawns[i].setLocation(location.x, location.y);
          spawns[i].setWarning(1);
          spawns[i].setValue(0);
          
          i = spawns.length;
        }
      }
    }
  }
  
  //govern smaller enemy behavior
  void extraBehavior()
  {
    for (int i = 0; i < spawns.length; i++)
    {
      spawns[i].behave();
    }
    
    //check hits
    spawnHitPlayer(player);
    
    spawnHitBullet(bullets);
  }
  
  //check if spawns hit bullets
  void spawnHitBullet(Bullet[] bullets)
  {
    for (int i = 0; i < bullets.length; i++)
    {
      for (int j = 0; j < spawns.length; j++)
      {
        spawns[j].hit(bullets[i]);
      }
    }
  }
  
  //check if spawns hit player
  void spawnHitPlayer(PVector player)
  {
    for (int i = 0; i < spawns.length; i ++)
    {
      if (spawns[i].hit(player))
      {
        if (! shield)         //ensure the shield is not up
          playerHit();
        
        //reduce powerup timer if shield is active
        else
        {
          spawns[i].explode();
          powerUpTime -= 100;
        }
      }
    }
  }
}
