//spiraling enemy that moves randomly
//spiraler will shrink and slow down as player approaches
//effective at blocking the player's bullets across long distances
class Spiraler extends Enemy
{
  float sAngle = PI;          //angle of spiral
  float sAngleChange = .2;    //increment sAngle changes by
  
  //movement variables
  float timeX = random(0,1000);
  float timeY = random(0,1000);
  float increment = 0.005;
  float proximity;
  
  int tNumber = int(random(3,6));            //number of trails
  
  Trail[] sTrails = new Trail[tNumber];
  
  Spiraler(float tempSpeed, float tempSize, int code)
  {
    super(tempSpeed, tempSize, code, false);
    
    //based hit points and value on number of trails
    hp = tNumber;
    value = tNumber;
    
    //fill array of trail
    for (int i = 0; i < hp; i++)
      sTrails[i] = new Trail((int)(10 * P_DEN), (int)(5 * P_DEN), 3);
      
    // Get a noise value at "time" and scale it according to the window's width.
    location.x = noise(timeX) * width;
    location.y = noise(timeY) * height;
  }
  
  void move()
  {
    // Get a noise value at "time" and scale it according to the window's width.
    location.x = noise(timeX) * width;
    location.y = noise(timeY) * height;
    
    //determine proximity and use to determine increment
    proximity = dist((int)player.x, (int)player.y, location.x, location.y);
    increment = pow(proximity, 1 / 1.8) / 1500 * eSpeed;
    
    //increase the noise by increment
    timeX += increment;
    timeY += increment;
  
    display(proximity);
  }
  
  void display(float proximity)
  {    
    //draw number of trails based on hp, with a length based on proximity
    for (int i = 0; i < hp; i++)
      sTrails[i].generate (sqrt(proximity) / 2, sAngle + i * 2 * PI / tNumber, location.x, location.y, eCode);

    //change angle based on proximity
    sAngleChange = sqrt (proximity) / 150;
    
    sAngle += sAngleChange;
  }
}
