void anim()
{
  if(started)
  {
  pushMatrix();
  translate(width/2,3.5*height/4 -25-lf*100);
  noStroke();
  color c=color(20+(grip*10),255-(grip*10),0);
  fill(c);
  sphere(25+(5*grip));
  popMatrix();
  }
}