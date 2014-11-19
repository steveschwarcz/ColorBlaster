//abstract class that holds all boss enemies
abstract class Boss extends Enemy
{  
  Boss(float tempSpeed, float tempSize, int code, boolean homing)
  {
    super(tempSpeed, tempSize, code, homing);
    
    explosion = new Implosion(9);
    
    livingB ++;
  }
  
  //initializes particles to a shape based on whether i is odd or even
  //initializes particles to an angle between the two given
  void initParticles(int i, float minA, float maxA, float minS, float maxS)
  {
    //make a third of the particles particles, a third TPatricles, and a third DParticles
      if (i % 3 == 0)
        particles[i] = new Particle (7, eSize, minS, maxS, minA, maxA);
      else if (i % 3 == 1)
        particles[i] = new TParticle (7, eSize, minS, maxS, minA, maxA);
      else
        particles[i] = new DParticle (7, eSize, minS, maxS, minA, maxA);

      particles[i].setCode(9);
      particles[i].setSize(15, 20);
  }
  
  //function to warn player that enemy is about to spawn in current location
  void warning()
  {  
    //create a small explosion for the duration of the warning timer
    if (! explosion.getHappening())
        explosion.boom(10,35,4);
  }
  
  //reduce counters on enemy after explosion (all child classes must include this line)
  void extraExplode()
  {
    explosion = new Explosion(9);
    
    livingB --;
  }
}
