//stores all the data for an explosion
//to use, an obeject must have an explosion instanciated when it is first created
//in order for the explosion to work properly, the check method must be used every frame
class Explosion
{
  color c;
  float xpos;
  float ypos;
  boolean happening = false;
  float s;
  float expan;
  float t;
  float w;
  float b;        //explosion size
  
  Explosion (int code)
  {        
    //get color
    c = colorize (code);
  }
  
  void boom (float is, float fs, float es)              //initial size, final size, explosion speed
  {
    happening = true;
    s = 1;            //size
    t = 255;          //transparency
    expan = es;       //expansion speed
    w = is;           //thickness or initial size
    b = fs;           //final size of explosion
    
    extraBoom();
  }
  
  //check if explosion is happening and create effect at x and y
  void check (float x, float y)
  {
    if (happening)
    {
      noFill();
      strokeWeight (w);
      stroke (c, t);
      ellipse (x, y, s, s);

      //change values to create effect
      effect();
    }
  }
  
  boolean getHappening()
  {
    return happening;
  }
  
  void setHappening(boolean happening)
  {
    this.happening = happening;
  }

  void effect()
  {
    s += expan;
    t -= 360 / b;
    w += 1;
    
    //end explosion 
    if (t < 0)
    {
      happening = false;
    }
  }

  //Special function ot add extra features to the boom function
  void extraBoom()
  {
  }
}





//*****************
//    IMPLOSION
//*****************

//implosion class.  creates an explosion that starts full and shrinks
class Implosion extends Explosion
{
  Implosion (int code)
  {
    super(code);
  }
  
  //complete the explosion in a single frame
  void extraBoom()
  {
    int i;
    
    i = (int)(255 / (360 / b)) + 1;
    
    s = 1 + i * expan;
    t = 0;
    w = i + 1;
  }
  
  //reverse the explosive effect
  void effect()
  {
      s -= expan;
      t += 360 / b;
      w = max(w - 1, 0);
    
    //end explosion 
    if (t > 255)
    {
      happening = false;
    }
  }
}
