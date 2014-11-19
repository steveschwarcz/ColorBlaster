//standard enemy that serves as ancestor to all other types of enemies
//moves in a single direction and bounces when it hits an edge
class Enemy
{
  //universal enemy variables
  Particle[] particles;    //array of particles
  Explosion explosion;     //creates an explosion class
  int eCode;               //enemy color Code
  PVector location;        //enemy location
  PVector velocity;        //enemy velocity
  float eSize;             //Size of enemy
  float eSpeed;
  boolean alive = false;   //Whether or not the enemy is alive
  float eAngle;            //angle of enemy movement
  
  //enemy type variables
  int value = 1;           //value of enemy in points
  int warning = 60;        //the legnth of the warning period before an enemy spawns
  int hp = 1;              //the health points of an enemy
  
  //homing variables
  boolean homing = false;                 //boolean value to determine if enemy is homing onto another
  float track = random(.2, .4);    //determines maximum tracking effect
  PVector target;
  PVector desired;
  
  Enemy(float tempSpeed, float tempSize,int code, boolean homing)
  {
    eSpeed = tempSpeed * mod;                                                  //initialize speed by mutiplying parameter by mod
    eAngle = random (0, 2 * PI);                                               //randomize angle
    location = new PVector (random(1, width), random (1, height));             //randomize locaiton
    velocity = new PVector (eSpeed * cos(eAngle), eSpeed * sin(eAngle));       //get velocity based on angle
    eCode = code;                                                              //set color code
    eSize = tempSize;                                                          //set size
    this.homing = homing;                                                      //set homing
    
    //make array for particles and base their number on enemy size
    particles = new Particle[(int)(eSize * P_DEN)];
    
    //initialize explosion
    explosion = new Explosion(eCode);    
  }
  
  void behave()
  {
    extraBehavior();
    
    //warning and spawn behavior
    if (! alive && warning > 0)
    {
      extraWarning();
      
      warning --;            //reduce warning counter
      
      //gives an enemy specific warning
      warning();
      
      //bring enemy to life when timer runs out
      if (warning <= 0)
      {
        alive = true;
        
        //spawn enemy
        spawn();
      }
    }
    
    
    //NOTE: NOT TESTED
    //move
    if (alive)
    {
      move();
      
      //track if homing is true
      if (homing)
        tracking();
    }
    
    explosion.check(location.x, location.y);                //check to see if enemy is currently exploding
  }
  
  //kill enemy and trigger explosion
  void explode()
  {
    extraExplode();
    
    alive = false;
    explosion.boom (eSize, eSize, 3);                //tell enemy counter enemy is dead
    boom.trigger();
  }
  
  //kill enemy
  void kill()
  {
    alive = false;
    warning = 0;
  }
  
  //function to warn player that enemy is about to spawn in current location
  void warning()
  {  
    //create a small explosion for the duration of the warning timer
    if (! explosion.getHappening())
        explosion.boom(10,15,3);
  }
  
  //creates particle array for enemies
  void spawn()
  {
    //fill array of particles
    for(int i = 0; i < particles.length; i++)
    {
      particles[i] = new Particle (eCode, eSize, 1, 4, 0, 2 * PI);
    }
  }
  
  void move()
  {
    extraMove();
    
    //display
    display();
    
    //move
    location.add(velocity);
    
    //check if on boundary
    velocity.x = edge(location.x, velocity.x, width);
    velocity.y = edge(location.y, velocity.y, height);
  }
  
  void display()
  {
    generate(location.x, location.y);
    
    extraDisplay();
  }
  
  //generate particles enemy
  void generate(float x, float y)
  {
    //generate particles      
    for (int i = 0; i < particles.length; i++)
    {
      particles[i].effect(x, y);
    }
  }
  
  
  void hit(Bullet b)
  {
    //add any extra hitting effects
    extraHit();
    
    if (b.getFiring() && dist ((int)location.x, (int)location.y, (int)b.getLocation().x, (int)b.getLocation().y) <= eSize + b.getSize() / 2)
    {
      if (alive)
      {
        b.setFiring(false);              //remove bullet
        hp --;                           //reduce hp
        
        if (hp <= 0)
        {
          explode();                       //destroy enemy
        
          //change score based on size of bullet
          if (! b.getLarge() && ! b.getLaser())
            score += value * multiplier;     //change score for small bullet
            
          //if bullet is laser
          else if (b.getLaser())
          {
            b.setFiring(true);
          }
          
          //if bullet is large
          else if (b.getLarge())
          {
            if (eCode == b.getCode())
            {  
              //perform special bullet actions
              specialHit(eCode);
              
              score += LARGE_S *  value * multiplier;      //add to score
            }
          }
        }
      }
    }
  }
  
  boolean hit(PVector player)
  { 
    boolean contact = false;
    
    if (alive)
    {      
      if (dist ((int) location.x, (int)location.y, player.x, player.y) <= eSize + 10 * sSize)
      {
        contact = true;
      }
      else
      {
        contact = false;
      }
      
      contact = extraHitPlayer(contact);
    }
    
    return contact;
    //return false;
  }
  
  //tracks player by essentially averaging the velocity with the path to the player
  void tracking()
  {
    //set taqrget vector the the spot the ship will be in 3 frames
    target = pVelocity.get();
    
    target.mult(3);
    target.add(player);
    
    //set desired to the vector between the target and the player
    desired = PVector.sub(target, location);
    
    //sets desired to a fixed number
    //This says that whatever angle the enemy has to move in order to get closer
    //to the player, it must go a fixed distance (track) in that direction
    desired.normalize();
    desired.mult(track * mod / 2);
    
    //add the desired to the velocity, forcing it into that direction
    velocity.add(desired);
        
    //note: there are two different methods for determining velocity
    
    //method 1: the object will always move at the given speed
    /*velocity.normalize();
    
    velocity.mult(eSpeed * mod);*/
    
    //method 2: the object can slow down, however since desired will always
    //affect velocity by a fixed amount, the effect is minimized
    velocity.limit(eSpeed);
    
    calculateAngle();
  }
  
  //gets angle of enemy (not used for regular enemies)
  void calculateAngle()
  {
    //eAngle = velocity.heading2D();
  }
  
  void setTrack(float track)
  {
    this.track = track;
  }
  
  void setLocation (float x, float y)
  {
    location = new PVector(x, y);
  }
  
  void setAlive(boolean alive)
  {
    this.alive = alive;
  }
  
  boolean getAlive()
  {
    return alive;
  }
  
  int getCode()
  {
    return eCode;
  }
  
  boolean getExplosion()
  {
    return explosion.getHappening();
  }
  
  PVector getLocation()
  {
    return location;
  }
  
  int getWarning()
  {
    return warning;
  }
  
  void setValue(int temp)
  {
    value = temp;
  }
  
  void setWarning(int temp)
  {
    warning = temp;
  }
  
  //Special function to add extra factors to behavior
  void extraBehavior()
  { 
  }
  
  //Special function to add extra factors to warning
  void extraWarning()
  { 
  }
  
  //Special function to add extra factors to explosion
  void extraExplode()
  { 
  }
  
  //Special function to add extra factors to moving enemy
  void extraMove()
  { 
  }
  
  //Special function to add extra factors to displaying enemy
  void extraDisplay()
  { 
  }
  
  //Special function to add extra factors in hitting enemies
  void extraHit()
  { 
  }
  
  //Special function to add extra conditions underwhich the player would hit an enemy
  boolean extraHitPlayer(boolean contact)
  {
    return contact;
  }
  
  //bounce off wall
  float edge (float pos, float z, float b)
  {
    if (pos >= b)
      z = - abs (z);
    if (pos <= 0)
      z = abs (z);
    return z;
  }
}
