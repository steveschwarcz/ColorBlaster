//produces a triangular particle
class TParticle extends Particle
{
  PVector [] points = new PVector [3];

  float tAngle = random(0, 2 * PI);
  
  TParticle(int code, float es, float minV, float maxV, float minAngle, float maxAngle)
  {
    super(code, es, minV, maxV, minAngle, maxAngle);
  }
  
  void display(float ex, float ey)
  {        
    setPoints(ex, ey, pSize / 1.5);
    
    drawShape(points);

    tAngle += PI / 360;
  }
  
  void setPoints(float ex, float ey, float tSize)
  {
    //set location of each point
    for(int i = 0; i < points.length; i++)
    {
      //set location relative to triangle's center
      points[i] = new PVector(tSize * cos(tAngle + (2 * i) * PI / 3), tSize * sin(tAngle + (2 * i) * PI / 3));
      
      //set location n screen
      points[i].x += ex + location.x;
      points[i].y += ey + location.y;
    }
  }
  
  void drawShape(PVector[] points)
  {
    triangle(points[0].x, points[0].y, points[1].x, points[1].y, points[2].x, points[2].y);
  }
}
