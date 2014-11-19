//an enemy that uses DParticles to signal it's increased power over a normal enemy
//notable for more precise homing
class DEnemy extends Enemy
{  
  DEnemy(float tempSpeed, float tempSize, int code, boolean homing)
  {
    super (tempSpeed, tempSize, code, homing);
    
    track = random(.7, .9);
    value = 4;
  }
  
  //creates particle array for enemies
  void spawn()
  {
    //fill array of particles
    for(int i = 0; i < particles.length; i++)
    {
      particles[i] = new DParticle (eCode, eSize, 1, 4, 0, 2 * PI);
    }
  }
}
