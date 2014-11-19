//all power up related variables

final int POWER_UP = 500;          //time for which power ups last

int powerUpTime = 0;               //the number of frames a power up lasts
int barWidth = 300;                //the width of a full powerup bar
int barHeight = 25;                //the hieght of a power up bar
int barLocation = 30;              //distance between bar and bottom of screen
float remainingBarWidth;           //the length of portion of the powerup bar that's used

final float SHIELD_BONUS = 1.5;          //time bonus for shield duration
final float SHOT_SPREAD = 14;            //spread of spread shot (higher = tighter)

//booleans to determine the truth value of each type of powerup
boolean laser = false;
boolean spread = false;
boolean shield = false;

String barText;                     //the text of the power up bar at the bottom of the screen

//determines what power up the player gets
void powerUp()
{
  int powerUp = int(random(0, 8));
  
  //sets powerup notice to last for the given number of frames
  noticeTimer = NOTICE_TIMER;
  noticeFlash = true;  
  powerUpTime = POWER_UP;
  
  //deactivate any already active power ups
  laser = false;
  spread = false;
  shield = false;
  
  //free nuke
  if (powerUp == 0) 
  {
    nukes ++;
    noticeText = "+1 Nuke";
    powerUpTime = 0;
  }
  
  //free life
  else if (powerUp == 1)
  {
    lives ++;
    noticeText = "+1 Life";
    powerUpTime = 0;
  }
  
  //laser
  else if (powerUp >= 2 && powerUp < 4)
  {
    //deactivate any already active power ups
    spread = false;
    //shield = false;
  
    laser = true;
    noticeText = "Power Up: Laser";
    barText = "LASER";
  }
  
  //spread
  else if (powerUp >= 4 && powerUp < 6)
  {
    //deactivate any already active power ups
    laser = false;
    //shield = false
    
    spread = true;
    noticeText = "Power Up: Spread Shot";
    barText = "SPREAD";
  }
  
  //shield
  else if (powerUp >= 6 && powerUp < 8)
  {
    shield = true;
    noticeText = "Power Up: Shield";
    barText = "SHIELD";
    powerUpTime *= SHIELD_BONUS;
  }
}

//check up on power up
void powerUpCheck()
{
  powerUpTime --;                      //reduce time until power up ends
  
  //end powerups
  if (powerUpTime <= 0)
  {
    laser = false;
    spread = false;
    shield = false;
  }
  //continue to draw if powerup time remains
  else
  {
    //determine length of bars
    if (! shield)
      remainingBarWidth = map(powerUpTime, 0, POWER_UP, 0, barWidth);
    else
      remainingBarWidth = map(powerUpTime, 0, POWER_UP * SHIELD_BONUS, 0, barWidth);
    
    //draw power up bar
    rectMode(CENTER);
    fill(255, 0, 0);
    stroke(0, 0, 255, 180);
    strokeWeight(3);
    rect(width / 2, height - barLocation, barWidth, barHeight);
    
    //draw the portion that's unsed above it
    fill(0, 0, 255, 180);
    noStroke();
    rect(width / 2, height - barLocation, remainingBarWidth, barHeight);
    
    //draw power up text
    textAlign(CENTER, CENTER);
    fill(255, 230);
    text(barText, width / 2, height - barLocation); 
  }
}
