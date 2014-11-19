//a boss that tracks the player.  Uses a completely different tracking code.

//instead of effectively averaging direction to player with velocity,
//the snake will always accelerate directly towards the player
//making it noticably more precise than a missile

class Snake extends Boss
{
  PVector acceleration = new PVector(0, 0);        //acceleration array that is recalculated each frame
  float force;                              //the force by which it moves towards player
  Trail tail;

  Snake()
  {
    super(7.5, 30, 9, true);
    
    force = .1 * mod;
    
    eSize = 40;
    
    hp = 35;
    value = 5;
    warning = 100;
  
    velocity = new PVector (0, 0);
    
    tail = new Trail((int)(25 * P_DEN), (int)(20 * P_DEN), 1.25);
    
    tail.setTrans(180, 100);
    tail.setBase(15, 8);
    
    //track = 1;
  }
  
  void extraMove()
  {
    velocity.add(acceleration);
    velocity.limit(eSpeed);
  }
  
  void display()
  {
    tail.generate(12, eAngle, location.x, location.y, 9);
    
    generate(location.x, location.y);
    
    //draw ellipses to represent remaining hp
    for (int i = hp; i >= 0; i--)
    {
      fill(colorize(8), 40);
      ellipse(location.x, location.y, i * 1.4, i * 1.4);
    }
  }
  
  void tracking()
  {
    //set target vector the the spot the ship will be in 3 frames
    target = pVelocity.get();
    
    target.mult(3);
    target.add(player);
    
    //set desired to the vector between the target and the player
    desired = PVector.sub(target, location);
    
    //sets desired to a fixed number(based on speed as supposed to a separate variable)
    desired.normalize();
    desired.mult(eSpeed);
    
    //acceleration is set to the difference between desired and velocity
    //thus, in theory, the missile would hit instantly
    acceleration = PVector.sub(desired, velocity);
    
    //limit acceleration, so that the missile does not hit instantly
    //force is the maximum amount the snake can accelerate
    acceleration.limit(force);
    
    //calculate angle
    eAngle = velocity.heading2D();
  }
  
  /*void calculateAngle()
  {
    eAngle = velocity.heading2D();
  }*/
  
  //override edge method so snake can leave screen
  float edge(float pos, float z, float b)
  {
    return z;
  }
}
  
