void update() {
  if ( overaffected((int)(width/2 - rectsize/2),100-rectSize/2, rectsize, rectSize) ) {
    normalOver = true;
    affectedOver = false;
  } else if ( overaffected((int)width/5 - rectsize/2,100-rectSize/2, rectsize, rectSize) ) {
    affectedOver = true;
    normalOver = false;
  } else if ( overaffected((int)(width/1.2 - rectsize/2),(int)100-rectSize/2, rectsize, rectSize))  {
    evalOver = true;
  }
  else {
    normalOver = affectedOver = evalOver = false;
  }
}

boolean overaffected(int x, int y, int width, int height)  {
  if (mouseX >= x && mouseX <= x+width && 
      mouseY >= y && mouseY <= y+height) {
    return true;
  } else {
    return false;
  }
}