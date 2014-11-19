//variables at game start
void reset()
{
  //determine starting variables based on difficulty
  if (difficulty == EASY)
  {
    mod = MOD_E;                   //speed modifier
    multiplier = MULT_E;           //score mulitplier
    respawnRate = SPAWN_E;         //respawn rate 
    
    stdMod = STANDARD_MOD_E;
    scMod = SCORING_MOD_E;
    maxMod = MAX_MOD_E;
    timeMod = TIME_MOD_E;
    minSpawn = MIN_SPAWN_E;
    consecSpawn = C_SPAWN_E;
  }
  
  else if (difficulty == MEDIUM)
  {
    mod = MOD_M;                   //speed modifier
    multiplier = MULT_M;           //score mulitplier
    respawnRate = SPAWN_M;         //respawn rate
    
    stdMod = STANDARD_MOD_M;
    scMod = SCORING_MOD_M;
    maxMod = MAX_MOD_M;
    timeMod = TIME_MOD_M;
    minSpawn = MIN_SPAWN_M;
    consecSpawn = C_SPAWN_M;  
  }
  
  else if (difficulty == HARD)
  {
    mod = MOD_H;                   //speed modifier
    multiplier = MULT_H;           //score mulitplier
    respawnRate = SPAWN_H;         //respawn rate 
    
    stdMod = STANDARD_MOD_H;
    scMod = SCORING_MOD_H;
    maxMod = MAX_MOD_H;
    timeMod = TIME_MOD_H;
    minSpawn = MIN_SPAWN_H;
    consecSpawn = C_SPAWN_H;
  }
  
  //reset balance variables   
  
  //reset game variables
  score = 0;
  lives = LIVES;
  nukes = NUKES;
  cCode = int(random(1,9));
  oCode = randP(cCode);
  playing = true;
  alive = true;
  livingE = 0;              //number of living enemies  
  gameLength = 0;  
  reload = 0;
  maxB = 0;
  
  //booleans to determine the truth value of each type of powerup
  laser = false;
  spread = false;
  shield = false;
  
  //reset player 
  aim = new PVector (mouseX, mouseY);
  player = new PVector (width / 2, height / 2);
  pTrail = new Trail(15, 11, 1.25);
  death.setHappening(false);
  newLife.setHappening(false);
  
  //fill array of enemies
  for (int i = 0; i < enemies.length; i++)
    enemies [i] = new Enemy (random (1.5,2.5), 30, oCode, true);
  
  //kill extra enemies
  for (int i = livingE + 1; i < enemies.length; i++)
  {
    enemies[i].kill();
  }
    
  //fill bullets array
  for (int i = 0; i < bullets.length; i++)
    bullets[i] = new Bullet ();
  
  //turn of instructions display if on
  instructions = false;
}
