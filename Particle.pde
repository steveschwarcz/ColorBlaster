//basic particle class that serves as ancestor for all other types of particles
//produces a round particle
class Particle
{
  PVector location = new PVector (0, 0);  //location
  PVector velocity;                       //velocity
  float minV;                             //minimum velocity
  float maxV;                             //maximum velocity
  float minS = 8;                         //minimum size      OLD: 8
  float maxS = 17;                        //maximum size      OLD: 15
  float minAngle;                         //minimum angle of particle
  float maxAngle;                         //maximum angle of particle
  float pSize = random (minS,maxS);       //size
  color pColor;                           //color
  float t = random(0, 255);               //transparency
  float pLife;                            //particle life (lower value = longer life)
  int pCode;                              //particle color code
  
  //variables that will only be used in temporary ways
  float tempAngle;
  float pSpeed;
    
  
  Particle(int code, float es, float minV, float maxV, float minAngle, float maxAngle)
  {
    pCode = code;
    
    noStroke();
  
    //assign color based on code
    pColor = colorizeG (code);
    
    //get max and min velocities
    this.minV = minV;
    this.maxV = maxV;
    
    //get speed
    pSpeed = random(minV, maxV);
    
    //get Angle
    this.minAngle = minAngle;
    this.maxAngle = maxAngle;
    tempAngle = random(minAngle, maxAngle);
    
    velocity = new PVector (pSpeed * cos(tempAngle),pSpeed * sin(tempAngle));
    
    pLife = 500/es;          //base particle life on size of enemy 
  }
  
  void effect (float ex, float ey)
  {    
    //particle effect
    fill (pColor, t);
    stroke (colorizeF(pCode));
    strokeWeight (1);
    display(ex, ey);
    
    //move particle
    location.add(velocity);
    
    //transparency change [Particle Life]
    t -= pLife;
    
    //reset location and particle information
    if (t <= 0)
    {
      location = new PVector (0, 0);
      
      t = 255;
      
      pSpeed = random(minV, maxV);
      
      pSize = random (minS,maxS);  
      
      tempAngle = random(minAngle, maxAngle);
    
      velocity = new PVector (pSpeed * cos(tempAngle),pSpeed * sin(tempAngle));
    }
    
    noStroke();
  }
  
  void display(float ex, float ey)
  {
    ellipse (ex + location.x, ey + location.y, pSize, pSize);
  }
  
  //sets min and max size
  void setSize(float minS, float maxS)
  {
    this.minS = minS;
    this.maxS = maxS;
  }
  
  void setCode(color tempCode)
  {
    pCode = tempCode;
  }
}

