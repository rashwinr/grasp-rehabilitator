void legend()
{
  stroke(#030303);
  strokeWeight(1);
  fill(#FFFFFF);
  rect(floor(width/30),floor(height*8/10),350,120);
  textFont(myFont,20);
  textAlign(CENTER,TOP);
  fill(#030303);
  text("LEGEND",floor(width/30)+150,floor(height*8/10));
  stroke(#5C85EA);
  line(floor(width/30)+20,floor(height*8/10)+35,floor(width/30)+100,floor(height*8/10)+35);
  textAlign(LEFT, CENTER);
  fill(#5C85EA);
  text("Lift Force (LF)",floor(width/30)+120,floor(height*8/10)+35);
  stroke(#0337FF);
  line(floor(width/30)+20,floor(height*8/10)+55,floor(width/30)+100,floor(height*8/10)+55);
  textAlign(LEFT, CENTER);
  fill(#0337FF);
  text("Lift Force Rate(LFR)",floor(width/30)+120,floor(height*8/10)+55);
  stroke(#C69097);
  line(floor(width/30)+20,floor(height*8/10)+75,floor(width/30)+100,floor(height*8/10)+75);
  textAlign(LEFT, CENTER);
  fill(#C69097);
  text("Grasp Force (LF)",floor(width/30)+120,floor(height*8/10)+75);
  stroke(#FF0324);
  line(floor(width/30)+20,floor(height*8/10)+95,floor(width/30)+100,floor(height*8/10)+95);
  textAlign(LEFT, CENTER);
  fill(#FF0324);
  text("Grasp Force Rate(LFR)",floor(width/30)+120,floor(height*8/10)+95);
}