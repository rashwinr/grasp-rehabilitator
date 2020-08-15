void mousepos()
{
  if(q==true)
  {
          fill(0);
 textFont(myFont, 20);
    textAlign(CENTER);
    text("mouse pressed   "+mouseX+"  "+mouseY,width/2,height/2);
  }
}
void mouseClicked() {
  if (normalOver) {
    w=false;
    s1=true;
  }
  if (affectedOver) {
    w=true;
    s1=true;
  }
  if(evalOver){
    eval=true;
  }
  
    if (overRect() && !started) {
    started=true;
  }
  else if (overRect() && started) {
    started = false;
  }
 // if(!q)q=true;
}