

void buttons()
{
  rect(rectX, rectY, 150, 50);
  textFont(myFont,32);
  textAlign(LEFT, TOP);
  fill(#C1AC65);
  if(!started)
  {
    fill(rectHighlight);
    text("Start",60,30);
  }
  if(started)
  {
    fill(circleHighlight);
    text("Stop",60,30);
  }
}

//void update() {
//if (overRect() ) {
//    rectOver = true;
//  } else {
//rectOver = false;
//  }
//}

boolean overRect()  {
  if (mouseX >= 25 && mouseX <= 175 && 
      mouseY >= 25 && mouseY <= 75) {
    return true;
  } else {
    return false;
  }
}

void mouseClicked() {
  if (overRect() && !started) {
    started=true;
  }
  else if (overRect() && started) {
    started = false;
  }

}