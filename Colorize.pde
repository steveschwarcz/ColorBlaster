//a collection of variations on the colorize code

//1: red, 2: green, 3: blue, 4: yellow, 5: violet, 
//6: teal, 7: white, 8: multi, 9: black (where applicable)

//*****************
//    STANDARD
//*****************
//picks a random color based on color code number
color colorize (int code)
{
  float rand = random (50,255);
  float cr = 225;
  float cg = 225;
  float cb = 225;
  color c;
  
  switch (code){
    case 1:
      cg = rand;
      cb = rand;
      break;
    case 2:
      cr = rand;
      cb = rand;
      break;
    case 3:
      cr = rand;
      cg = rand;
      break;
    case 4:
      cb = rand;
      break;
    case 5:
      cg = rand;
      break;
    case 6:
      cr = rand;
      break;
    case 7:
      cr = rand;
      cg = rand;
      cb = rand;
      break;
    case 8:
      cr = random (0, 255);
      cg = random (0, 255);
      cb = random (0, 255);
      break;
    case 9:
      cr = rand;
      cg = rand;
      cb = rand;
      break;
  }
  
  c = color (cr, cg, cb);
  
  return c;
}




//*****************
//    GROUND
//*****************
color colorizeG (int code)
{
  float rand = random (50,255);
  float cr = 0;
  float cg = 0;
  float cb = 0;
  color c;
  
  switch (code){
    case 1:
      cr = rand;
      break;
    case 2:
      cg = rand;
      break;
    case 3:
      cb = rand;
      break;
    case 4:
      cr = rand;
      cg = rand;
      break;
    case 5:
      cr = rand;
      cb = rand;
      break;
    case 6:
      cg = rand;
      cb = rand;
      break;
    case 7:
      cr = rand;
      cg = rand;
      cb = rand;
      break;
    case 8:
      cr = random (0, 255);
      cg = random (0, 255);
      cb = random (0, 255);
      break;
  }
  
  c = color (cr, cg, cb);
  
  return c;
}



//*****************
//      FILL
//*****************

color colorizeF(int code)
{
  color f = color (0);
  
  switch (code)
  {
    case 1:
      f = color (255, 0, 0);
      break;
    case 2:
      f = color (0, 255, 0);
      break;
    case 3:
      f = color (0, 0, 255);
      break;
    case 4:
      f = color (255, 255, 0);
      break;
    case 5:
      f = color (255, 0, 255);
      break;
    case 6:
      f = color (0, 255, 255);
      break;
    case 7:
      f = color (255);
      break;
    case 8:
      f = color (random (0,255), random (0, 255), random (0, 255));
      break;
    case 9:
      f = color (0);
      break;
  }
  
  return f;
}




//*****************
//     STROKE
//*****************

color colorizeS(int code)
{
  color s = color(0);
  
  switch (code)
  {
    case 1:
      s = color (255, 255, 0);
      break;
    case 2:
      s = color (0, 155, 155);
      break;
    case 3:
      s = color (255, 0, 255);
      break;
    case 4:
      s = color (255, 0, 0);
      break;
    case 5:
      s = color (0, 0, 255);
      break;
    case 6:
      s = color (0, 155, 0);
      break;
    case 7:
      s = color (0);
      break;
    case 8:
      s = color (random (0,255), random (0, 255), random (0, 255));
      break;
    case 9:
      s = color(255);
      break;
  }
  
  return s;
}


//randomly generates a color code different from the current one
int rand (int r)
{
  int z;
  do
  {
    z = int(random(1,9));
  }
  while (z == r);
  
  return z;
}

//rand function that never comes up multicolor
int randP (int r)
{
  int z;
  do
  {
    z = int(random(1,8));
  }
  while (z == r);
  
  return z;
}
