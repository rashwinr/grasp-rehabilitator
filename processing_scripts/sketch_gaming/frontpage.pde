void frontpage()
{
if(s1!=true)
  {
   noFill();
   lights();
   background(#C9DEFF);
   fill(#27B8FF);
   textFont(myFont,32);
   textAlign(CENTER,CENTER);
   text("Grasp Rehabilitator",width/2,10);
   fill(#050505);
   textFont(myFont,32);
   textAlign(CENTER,CENTER);
   text("Re-training your precision grasp is made easy with us!",width/2,40);
   update();
   mousepos();
   stroke(#888C8E);
   strokeWeight(4);
   if (affectedOver) {
   fill(0);
   textFont(myFont,22);
   textAlign(CENTER,CENTER);
   text("Normal mode allows you to practice \nwith the involving hand",width/7,200);
    fill(circleHighlight);
  } else {
   fill(#C9DEFF);
  }
   rect((int)width/5 - rectsize/2,100-rectSize/2, rectsize, rectSize);
   if (normalOver) {
   fill(0);
   textFont(myFont,22);
   textAlign(CENTER,CENTER);
   text("Affected hand mode allows you to practice \nwith the non-involving hand observing the \nperformance of the involving hand",width/2,200);
   fill(circleHighlight);
  } else {
    fill(#C9DEFF);
  }
   rect((int)width/2 - rectsize/2,100-rectSize/2,rectsize, rectSize);
  if (evalOver) {
   fill(0);
   textFont(myFont,22);
   textAlign(CENTER,CENTER);
   text("Evaluate button allows you to observe the \nperformance of the involving side\n to the involving hand",width/1.2,200);
    fill(circleHighlight);
  } else {
   fill(#C9DEFF);
  }
     rect((int)width/1.2 - rectsize/2,100-rectSize/2,rectsize, rectSize);
        fill(0);
   textFont(myFont, 20);
   textAlign(CENTER,CENTER);
   text("Normal mode",width/5,100);
   text("Affected mode",width/2,100);
   text("Evaluate",width/1.2,100);
  }
}