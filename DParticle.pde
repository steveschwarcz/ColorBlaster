//produces a diamond shaped particle
class DParticle extends TParticle
{
  float narrow = 2;            //narrowness of DParticle (higher = more narrow)
  
  DParticle(int code, float es, float minV, float maxV, float minAngle, float maxAngle)
  {
    super(code, es, minV, maxV, minAngle, maxAngle);
    
    points = new PVector [4];
  }
  
  void setPoints(float ex, float ey, float tSize)
  {
    //set location of each point
    for(int i = 0; i < points.length; i++)
    {
      //set location relative to particle's center
      if (i % 2 == 0)
        points[i] = new PVector(tSize * cos(tAngle + (2 * i) * PI / 4), tSize * sin(tAngle + (2 * i) * PI / 4));
      else
        points[i] = new PVector(tSize / narrow * cos(tAngle + (2 * i) * PI / 4), tSize / narrow * sin(tAngle + (2 * i) * PI / 4));
      
      //set location n screen
      points[i].x += ex + location.x;
      points[i].y += ey + location.y;
    }
  }
  
  void drawShape(PVector[] points)
  {
    beginShape();
    //puts a vertex at each point
    for(int i = 0; i < points.length; i++)
      vertex(points[i].x, points[i].y);
    endShape(CLOSE);
  }
}
