
void drawplot()
{
  pg.beginDraw();
  pg.stroke(10);
  pg.strokeWeight(2);
  int x=pg.width, y =  pg.height;
  pg.line(floor(x/20),floor(y/10),floor(x/20),floor(0.9*y));
  drawArrow(floor(0.9*x),floor(0.9*y),15,0);
  drawArrow(floor(x/20),floor(y/10),15,-90);
  pg.line(floor(x/20),floor(0.9*y),floor(0.9*x),floor(0.9*y));
  pg.line(floor(0.915*x),floor(y/10),floor(0.915*x),floor(0.9*y));
  drawArrow(floor(0.915*x),floor(y/10),15,-90);
  int l = floor(0.9*x) - floor(x/20);
  int h = floor(0.9*y) - floor(y/10);
  pg.textFont(myFont1,20);
  pg.textAlign(LEFT, TOP);
  pg.fill(#5C85EA);
  pg.text("0",20,floor(0.88*y));
  pg.text("2.0",10,floor(0.78*y));
  pg.text("4.0",10,floor(0.68*y));
  pg.text("6.0",10,floor(0.58*y));
  pg.text("8.0",10,floor(0.48*y));
  pg.text("10.0",10,floor(0.38*y));
  pg.text("12.0",10,floor(0.28*y));
  pg.text("14.0",10,floor(0.18*y));
  pg.text("16.0",10,floor(0.08*y));
  pg.fill(#AB7BCE); 
    pg.text("0",0.915*x+20,floor(0.88*y));
  pg.text("4.0",0.915*x+10,floor(0.78*y));
  pg.text("8.0",0.915*x+10,floor(0.68*y));
  pg.text("12.0",0.915*x+10,floor(0.58*y));
  pg.text("16.0",0.915*x+10,floor(0.48*y));
  pg.text("20.0",0.915*x+10,floor(0.38*y));
  pg.text("24.0",0.915*x+10,floor(0.28*y));
  pg.text("28.0",0.915*x+10,floor(0.18*y));
  pg.text("32.0",0.915*x+10,floor(0.08*y));
  pg.textFont(myFont,24);
  pg.textAlign(LEFT, TOP);
  pg.fill(#5C85EA);
  pg.text("Lift/Grasp Forces",10,10);
  pg.fill(#AB7BCE); 
  pg.text("Lift/ Grasp Force Rates",0.75*x,10);
  pg.fill(21);
  pg.text("Time (seconds)",floor(x/2)-100,floor(0.94*y));
  //Drawing a line from Last inByte to the new one.
  if(!started)t=millis();
  if(i<=1075 && started)
  {
    pg.strokeWeight(1);
    pg.stroke(#5C85EA);
    pg.line(floor(x/20)+i-1,floor(0.9*y)-(prevlf/16)*h,floor(x/20)+i,floor(0.9*y)-(lf/16)*h);
    pg.stroke(#C69097);
    pg.line(floor(x/20)+i-1,floor(0.9*y)-(prevgrip/16)*h,floor(x/20)+i,floor(0.9*y)-(grip/16)*h);
    pg.strokeWeight(0.5);
    pg.stroke(#0337FF);
    pg.line(floor(x/20)+i-1,floor(0.9*y)-(lfrprev/32)*h,floor(x/20)+i,floor(0.9*y)-(lfr/32)*h);    
    pg.stroke(#FF0324);
    pg.line(floor(x/20)+i-1,floor(0.9*y)-(griprprev/32)*h,floor(x/20)+i,floor(0.9*y)-(gripr/32)*h);
    t1=millis();
    if(e<10){e =((t1-t)/1000);}
    else if(e>=10){e=0;}
    //println(e);
    //pg.text(e,floor(x/20)-1+,floor(0.9*y)+5);
    i++;
  }
  if(i>1075)
  {
  i=0;
  pg.background(#D6D8D8);
  }
  pg.endDraw();
}