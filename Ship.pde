//*****************
//      SHIP
//*****************

//ship variables
Trail pTrail;     //trail of ship
float px;         //previous x of ship
float py;         //previous y of ship
color f;          //fill color of player
color s;          //stroke color of player

void ship()
{
  //keys to move
  if(keys[W]) 
   {  
     player.y = max(10, player.y - sSpeed);
   }
   if(keys[A]) 
   {
     player.x = max(10, player.x - sSpeed);
   }
   if(keys[S]) 
   {
     player.y = min(height - 10, player.y + sSpeed);
   }
   if(keys[D]) 
   {
     player.x = min(width - 10, player.x + sSpeed);
   }
  
  //generate trail
  pTrail.generate(T_SIZE, aAngle, player.x, player.y, oCode);
  
  fill(f, 180); 
  stroke(255);
  strokeWeight (2); 
  
  rectMode (CENTER);
    
  //draw turret
  translate (player.x, player.y);
  rotate(aAngle + PI / 2);
  
  //draw ship
  triangle (sSize * 6, 0, sSize * 12, 0, sSize * 6, sSize * - 24);
  triangle (sSize * - 6, 0, sSize * - 12, 0, sSize * - 6, sSize * - 24);
  triangle (0, sSize * - 17, sSize * 6, sSize * - 10, sSize * - 6, sSize * - 10);
  triangle (sSize * 11, 0, sSize * - 11, 0, 0, sSize * 15);
  rect(0, sSize * - 5, sSize * 12, sSize * 12);
  
  f = colorizeF (oCode);
  s = colorizeS (oCode);
  
  if (oCode == 8 && frameCount % 10 == 0)
  {
    f = color (random (0,255), random (0, 255), random (0, 255));
    s = color (random (0,255), random (0, 255), random (0, 255));
  }
  
  noStroke();
  
  rotate(- aAngle - PI / 2);
  translate (- player.x,- player.y);
  
  //draw shield if shield power up is active
  if (shield)
  {
    for (int i = 20; i >= 0; i--)
    {
      fill(colorize(8), 20);
      ellipse(player.x, player.y, i * 3, i * 3);
    }
  }
}

//*****************
//   RETICLE
//*****************

void reticle ()
{
      //draw trigger    
    fill(f, 200);
    strokeWeight (1);
    stroke(s,100);
  
  //pointer reticle
  if (arrowReticle)
  {
    pushMatrix(); 
    translate (player.x, player.y);
     
   aAngle = atan2(aim.y, aim.x);
   
   aim.x += aimS * (mouseX - pmouseX);
   aim.y += aimS * (mouseY - pmouseY);
   
   aim.limit(reticle);  
  
    translate (aim.x, aim.y);
    rotate (atan2(aim.y, aim.x) + PI/2);
    triangle (0, - 8, 0, 0, 12, 5);
    triangle (0, - 8, 0, 0, - 12, 5);
    rotate (- atan2(aim.y, aim.x) - PI/2);
    translate(- aim.x, - aim.y);
  
    popMatrix();
  }
    
  //round reticle
  else if (! arrowReticle)
  {
    aim = new PVector (mouseX - player.x, mouseY - player.y);
    
    //draw
    ellipse(mouseX, mouseY, 17, 4);
    ellipse(mouseX, mouseY, 4, 17);
    noFill();
    stroke (s, 150);
    strokeWeight(2);
    ellipse(mouseX, mouseY, 17, 17);
    
    //get aim angle
    pushMatrix(); 
    translate (player.x, player.y);
     
    aAngle = atan2(aim.y, aim.x);
     
    popMatrix();
  }
}
