//bullet class.  

//bullet variables - these are contants that are useful since they allow text to be used to determine the type when firing
final int SMALL = 0;
final int LARGE = 1;
final int LASER = 2;
final int SPREAD = 3;

//all bullets belong to this class and are differenciated by boolean values
class Bullet
{
  PVector location = new PVector(1, 1);
  PVector velocity;
  float bSpeed = 7;
  float bSize;
  float bAngle;      //angle of bullet
  int bCode;
  boolean large;      //if true then bullet is a special shot
  boolean laser;      //if true then bullet is a laser
  boolean spread = false;     //if true then bullet is a spread shot
  boolean firing = false;
  
  Bullet ()
  {
  }
  
  //move bullet
  void move ()
  {
    if (firing)
      {
        location.add(velocity);
        
        //rotate
        pushMatrix();
        translate (location.x, location.y);
        rotate (bAngle);
        
        strokeWeight(2);
        stroke(colorizeS(bCode));
        fill (colorizeF(bCode));        
        
        //check for double shot, spread shot, laser shot
        if (! large)
        {
          if (! laser && ! spread)
          {
            ellipse (0, - 4, bSize * 2, bSize);
            ellipse (0, 4, bSize * 2, bSize);
          }

          else if (spread)
            ellipse (0, 0, bSize * 2, bSize);
            
          else if (laser)
          {
            noStroke();
            ellipse (0, 0, bSize * 6, bSize);
          }
          
        }
        
        else
          ellipse (0, 0, bSize * 2, bSize);
        
        noStroke();
        
        //unrotate
        popMatrix();
      }
      
    //stop firing if off screen
    if (location.y < 0 || location.y > height || location.x < 0 || location.x > width)
    {
      firing = false;
      //score -= penalty;              //Penalty for missing
    }
    
    //put to an insignificant locaiton if not firing (note: location must be onscreen)
    if(! firing)
      location = new PVector (1, 1);
  }
  
  //fires a bullet
  void fire(float initx, float inity, int code, int type, float addAngle)
  {    
    bCode = code;                      //set code of bullet color to code of parameter
    
    //reset bullet type
    large = false;
    spread = false;
    laser = false;
    
    //reset stats
    bSize = 7;
    bSpeed = 7;
    
    //set type of bullet
    switch (type)
    {
      case 0:
        break;
      case 1:
        large = true;
        bSize = 15;
        break;
      case 2:
        laser = true;
        break;
      case 3:
        spread = true;
        break;
    }
    
    //set initial bullet location
    location = new PVector(initx, inity);
    
    //rotate bullet
    pushMatrix ();
    translate(initx, inity);
    bAngle = atan2(aim.y, aim.x) + addAngle;
    
    popMatrix();
    
    //determine bullet velocity
    float vx = bSpeed * cos(bAngle) + CURVE * (pVelocity.x);
    float vy = bSpeed * sin(bAngle) + CURVE * (pVelocity.y);
    
    velocity = new PVector (vx, vy);
    
    //set firing to true
    firing = true;
  }
 
  void setFiring(boolean firing)
  {
    this.firing = firing;
  }
  
  boolean getFiring()
  {
    return firing;
  }
  
  PVector getLocation()
  {
    return location;
  }
  
  float getSize()
  {
    return bSize;
  }
  
  //set large and bullet size
  void setLarge(boolean large)
  {
    if (large)
      bSize = 15;
    else
      bSize = 7;
    
    this.large = large;
  }
  
  boolean getLarge()
  {
    return large;
  }
  
  int getCode()
  {
    return bCode;
  }
  
  boolean getLaser()
  {
    return laser;
  }
}
