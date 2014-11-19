//FIX lives, Max_E, Bcount, mod

//graphical variables 
final int G_DEN = 52;                          //Density of land blocks (higher value = less blocks) (even numbers work better)
final float P_DEN = 1;                         //Density of particles on screen

//difficulty variables - starting values for new game
//easy
final float MOD_E = .3;                         //initial speed modifier
final int MULT_E = 6;                           //initial score mulitplier
final int SPAWN_E = 50;                         //initial respawn rate of enemies

//medium
final float MOD_M = .5;                         //initial speed modifier
final int MULT_M = 4;                           //initial score mulitplier
final int SPAWN_M = 40;                         //initial respawn rate of enemies

//hard
final float MOD_H = .7;                         //initial speed modifier
final int MULT_H = 2;                           //initial score mulitplier
final int SPAWN_H = 30;                         //initial respawn rate of enemies


//difficulty variables - game pacing
//easy
final float STANDARD_MOD_E = .00025;            //standard rate at which speed of game increases
final float SCORING_MOD_E = .05;                //rate at which game speed increases when the player scores with a large shot
final float MAX_MOD_E = .8;                   //maximum modifier value
final float TIME_MOD_E = .8;                   //modifies game length timer.  useful to make enemies spawn sooner or later
final int MIN_SPAWN_E = 40;                    //maximum rate that enemies can spawn (note: lower = more spawns per second)
final int C_SPAWN_E = 1;                       //number of enemies that can spawn consecutively

//medium
final float STANDARD_MOD_M = .0005;            //standard rate at which speed of game increases
final float SCORING_MOD_M = .1;                //rate at which game speed increases when the player scores with a large shot
final float MAX_MOD_M = 1.2;                   //maximum modifier value
final float TIME_MOD_M = 1;                    //modifies game length timer.  useful to make enemies spawn sooner or later
final int MIN_SPAWN_M = 30;                    //maximum rate that enemies can spawn (note: lower = more spawns per second)
final int C_SPAWN_M = 2;                       //number of enemies that can spawn consecutively

//hard
final float STANDARD_MOD_H = .0005;            //standard rate at which speed of game increases
final float SCORING_MOD_H = .1;                //rate at which game speed increases when the player scores with a large shot
final float MAX_MOD_H = 1.4;                   //maximum modifier value
final float TIME_MOD_H = 1.2;                    //modifies game length timer.  useful to make enemies spawn sooner or later
final int MIN_SPAWN_H = 10;                    //maximum rate that enemies can spawn (note: lower = more spawns per second)
final int C_SPAWN_H = 2;                       //number of enemies that can spawn consecutively

//balance variables - starting values for new game (constant)
final int LIVES = 3;                          //starting number of lives
final int NUKES = 1;                          //starting number of nukes

//balance variables - scoring
final int LARGE_S = 0;                       //score multiplier for hitting with a large shot

//ship variables
float sSpeed = 4;                            //ship speed
float sSize = .8;                            //ship size
final float T_SIZE = 3.5;                    //trail size of ship
final int P_RESPAWN = 50;                    //number of frames until player respawns after death

//enemy variables
final int MAX_E = 16;                        //Maximum number of enemies onscreen at once
final int MAX_B = 2;                         //maximum number of bosses onscreen at once
final int B_COUNT = 0;                       //number of enemies a single boss counts as  (will prevent new enemies past MAX_E, but not new bosses)

//bullet variables
final float CURVE = .2;                      //curve of bullets while moving, i.e. the effect of the ship's movement on the bullet's trajectory
final int SMALL_FR = 5;                      //fire rate for small bullets
final int LARGE_FR = 10;                     //fire rate for large bullets

//reticle variables - arrow 
float aAimS = 2;                             //aim sensativity for arrow reticle
int aReticle = 50;                           //maximum distance of arrow reticle from ship

//reticle variables - circle
float cAimS = 1.3;                           //aim sensativity for circle reticle 
int cReticle = 70;                           //maximum distance of circle reticle from ship

//reticle variables - starting reticle
boolean arrowReticle = true;                 //makes reticle an arrow

//text variables
final int NOTICE_FLASH = 25;                 //standard number of frames for which notoce text flashes
final int NOTICE_TIMER = 124;                //standard number of frames for which notice text lasts (NOTE: works best if PU_TEXT is an odd multiple of PU_FLASH - 1)


//other variables (note: these variables are declared here only because they have to be declared after the above variables)
Enemy [] enemies = new Enemy [MAX_E];       //Declare enemy array 
