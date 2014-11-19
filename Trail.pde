//produces a trail that follows a point
class Trail
{
  int trans0 = 100;            //transparency of trail0
  int trans1 = 65;             //transparency of trail1
  float base0 = 1;             //base width of trail0
  float base1 = 1;             //base width of trail1
  
  //declare array for trail
  PVector [] t0;
  PVector [] t1;
  
  color trailF;
  color trailS;
  
  float tWidth;          //width of trail (as mulitplied by locaiton in trail and added to base
  
  Trail(int tLength0, int tLength1, float tempWidth)
  {
    t0 = new PVector[tLength0];
    t1 = new PVector[tLength1];
    tWidth = tempWidth;
    
    //initialize trail off screen
    for (int i = 0; i < t0.length; i++) 
    {
      t0[i] = new PVector (- 500, -500);
    }
    
    for (int i = 0; i < t1.length; i++) 
    {
      t1[i] = new PVector(- 500, -500);
    }
  }
  
  void generate(float tSize, float tAngle, float x, float y, int tCode)
  {
    for (int i = 0; i < t0.length - 1; i++) 
    {
      t0[i].x = t0[i+1].x - tSize * cos(tAngle);
      t0[i].y = t0[i+1].y - tSize * sin(tAngle);
    }
    
    for (int i = 0; i < t1.length - 1; i++) 
    {
      t1[i].x = t1[i+1].x - tSize * cos(tAngle);
      t1[i].y = t1[i+1].y - tSize * sin(tAngle);
    }
    
    t0[t0.length-1].x = x;
    t0[t0.length-1].y = y;
    t1[t1.length-1].x = x;
    t1[t1.length-1].y = y;
    
    for (int i = 0; i < t0.length; i++) {
      noStroke();
      fill (colorizeF(tCode), trans0);
      ellipse (t0[i].x,t0[i].y, (tWidth * i) + base0, (tWidth * i) + base0);
    }
    
    for (int i = 0; i < t1.length; i++) {
      noStroke();
      fill (colorizeS(tCode), trans1);
      ellipse (t1[i].x, t1[i].y, (tWidth * i) + base1, (tWidth * i) + base1);
    }
  }
  
  //method to set transparency of trails
  void setTrans(int trans0, int trans1)
  {
    this.trans0 = trans0;
    this.trans1 = trans1;
  }
  
  //method to set base width
  void setBase(float base0, float base1)
  {
    this.base0 = base0;
    this.base1 = base1;
  }
}
