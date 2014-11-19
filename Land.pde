//a block of land
class Land
{
  int xpos;           //X position
  int ypos;           //Y position
  int ls;             //size
  color c;            //color
  
  Land(int tempx, int tempy)
  {
    c = colorizeG (cCode);
    xpos = tempx;
    ypos = tempy - G_DEN;
    noStroke();
    
    ls =  G_DEN + int(random(0, G_DEN / 2));
  }
  
  void display()
  {
    rectMode(CORNER);
    noStroke();
    fill (c,100);
    rect (xpos, ypos, ls, ls); 
   
    //move ground
    ypos += 2;
  }
  
  int getY()
  {
    return ypos;
  }
}
