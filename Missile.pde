//missile enemy that fires itself in a random direction
class Missile extends Enemy
{
  Missile(float tempSpeed, float tempSize, int code, boolean homing)
  {
    super(tempSpeed, tempSize, code, homing);
    
    //type specific values
    if (! homing)
      value = 2;
    else
      value = 3;
    
    track = random(.4, .6);                              //maximum track speed of missile
    
    //warning particles
    for(int i = 0; i < particles.length; i++)
    {
      particles[i] = new Particle (eCode, eSize / 1.5, - 4, -2, PI / 6, 5 * PI / 6);
    }
    
    switch((int)((eAngle + PI / 4) / (PI /2)))
    {
      case 0:
        location = new PVector (0, random(1,height));
        break;
      case 1:
        location = new PVector (random(1, width), 0);
        break;
      case 2:
        location = new PVector (width, random(1,height));
        break;
      case 3:
        location = new PVector (random(1, width), height);
        break;
      default:
        location = new PVector (0, random(1,height));
        break;
    }
  }
  
  void warning()
  {  
    //rotate to position
    pushMatrix();
    translate(location.x, location.y);
    rotate(eAngle + PI / 2);
    
    //generate particles      
    for (int i = 0; i < particles.length; i++)
    {
      particles[i].effect(0, 0);
    }
    
    popMatrix();
  }
  
  void spawn()
  {
    //fill array of particles
    if (! homing)          //T particles if not homing
    {
      for(int i = 0; i < particles.length; i++)
      {
        particles[i] = new TParticle (eCode, eSize, 3, 6, 2 * PI / 6, 4 * PI / 6);
      }
    }
    else                    //D particles for homing
    {
      for(int i = 0; i < particles.length; i++)
      {
        particles[i] = new DParticle (eCode, eSize, 3, 6, 2 * PI / 6, 4 * PI / 6);
      }
    }
  }
  
  void move()
  {
    //rotate to position
    pushMatrix();
    translate(location.x, location.y);
    rotate(eAngle + PI / 2);
    
    //generate particles      
    for (int i = 0; i < particles.length; i++)
    {
      particles[i].effect(0, 0);
    }
    
    popMatrix();
    
    //move
    location.add(velocity);
    
    //check if on boundary
    if (location.x > width || location.x < 0 || location.y > height || location.y < 0)
    {
      explode();
    }
  }
  
  //gets angle of enemy (not used for regular enemies)
  void calculateAngle()
  {
    eAngle = velocity.heading2D();
  }
}
