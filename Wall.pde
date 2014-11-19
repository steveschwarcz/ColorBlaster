//Wall boss.  Shoot center to kill it, if player hits it anywhere, the game is over
class Wall extends Boss
{
  int a = 16;              //spread of particles (higher = tighter)
  
  float tempAngle;         //angle used for later calculation
  
  Wall()
  {
    super(.5, 120, 9, false);
    
    //set location
    location = new PVector(width / 2 - width / 2 * cos(eAngle), height / 2 - height / 2 * sin(eAngle));
    
    //set unique variables
    value = 5;
    hp = 30;
    warning = 100;
  }
  
  //gives a text display warning
  void extraWarning()
  {
    fill(255);
    textAlign(CENTER, CENTER);
    text("Incoming Wall Enemy", width / 2, height / 2 - 25);
    text("(avoid corners)", width / 2, height / 2 + 25);
  }
  
  //creates particle array for displaying
  void spawn()
  {               
    //fill first half of array of particles
    for(int i = 0; i < particles.length / 2; i++)
    {
      initParticles(i, (a / 2 - 1) * PI / a, (a / 2 + 1) * PI / a, 6, 7);
    }
    
    //fill second half of array of particles
    for(int i = particles.length / 2; i < particles.length; i++)
    {
      initParticles(i, - (a / 2 + 1)  * PI / a, - (a / 2 - 1) * PI / a, 5, 7);
    }
    
    /*return size to normal (note: with walls, the size is orignally quadrupelled to increase the number and life of particles,  
    it is now reduced for the sake of hit box calculation)*/
    eSize = 40;
  }
  
  void display()
  {
    pushMatrix();
    
    translate(location.x, location.y);
    rotate(eAngle);
    
    generate(0, 0);
    
    //draw ellipses to represent remaining HP
    for (int i = hp; i >= 0; i--)
    {
      fill(colorize(8), 50);
      ellipse(0, 0, i * 1.2, i * 2.4);
    }
    
    popMatrix();
  }
  
  //stop bullets from passing through wall
  /*void extraHit(Bullet b)
  {
    if(hitWall(b.getLocation().x, b.getLocation().y) && b.getFiring())
      b.setFiring(false);
  }*/
  
  boolean extraHitPlayer(boolean contact)
  {
    if (hitWall(player.x,player.y))
      return true;
    else
      return false;
  }
  
  boolean hitWall(float x, float y)
  {
    //angle between input and enemy
    tempAngle = atan2 (location.y - y, location.x - x);
    
    //fixes discrepency in atan2 function (atan2 uses a -PI to PI scale)
    if (tempAngle < 0)
      tempAngle += 2 * PI;
    
    //ensures that enemy and input are being compared along the same angle scale
    if (eAngle >= 0 && eAngle < PI / 2 && tempAngle > 3 * PI / 2)
      tempAngle -= 2 * PI;
    else if (eAngle > 3 * PI / 2 && eAngle <= 2 * PI && tempAngle < PI / 2)
      tempAngle += 2 * PI;
    
    if (abs(tempAngle - eAngle) >= PI / 2)
    {
      if (alive)
      {
        return false;
      }
    }

    return true;
  }
  
  //removes the unnecessary edge function
  float edge (float pos, float z, float b)
  {
    return z;
  }
}
