import processing.serial.*;
import java.util.Date;
Serial myPort;
PGraphics pg;
PrintWriter output;
final String serialPort = "COM11";
int SIZEX=1650;
int SIZEY=1050;
PFont myFont,myFont1;
int da = day();    // Values from 1 - 31
int mo = month();  // Values from 1 - 12
int ye = year();   // 2003, 2004, 2005, etc.
int s = second(); 
int m = minute(); 
int ho = hour(); 
boolean print = false, affectedOver = false, normalOver = false, evalOver=false, w=true,eval;
float Pc = 0.0, G = 0.0, Xp = 0.0, Zp = 0.0, Xe = 0.0;
int rectXY=25, rectYX=25;      // Position of button
color rectHighlight = #18DB37, circleHighlight = #D32D54;
color currentColor=#B7B5AE;
boolean rectOver = false, started = false, s1 =false, q = false;
int i=0, ij=0,k=0, t=0,t1=0,f=0, e=0, x,y,u = 0;
float lf=0.0,gf1=0.0,gf2=0.0,prevlf=0.0,grip=0.0, prevgrip=0.0,c=0.0;
float lfr=0.0,lfrprev = 0.0,gripr,griprprev,lfrnoise=1.0,gfrnoise=1.0; 
float alf,alfr,agf,agfr;
float anlf,anlfr,angf,angfr;
float nlf,nlfr,ngfr,ngf;
float varprocl=1E-2,varmeasl=0.015080;
float varprocg=1E-2,varmeasg=0.00371;
int rectsize = 180,rectSize=55;     // Diameter of rect
float[] normallfr = new float[10000];
float[] normallf = new float[10000];
float[] normalgf = new float[10000];
float[] normalgfr = new float[10000];
float[] affectedlfr = new float[10000];
float[] affectedlf = new float[10000];
float[] affectedgf = new float[10000];
float[] affectedgfr = new float[10000];
void setup()
{
  myPort = new Serial(this,serialPort, 250000);
  delay(10);
  myPort.clear();
  fullScreen(P3D);
  x=floor(width/1.15);
  y =  floor(height/1.5);
  smooth(2);
  myFont = createFont("HelveticaNeue-Bold", 32);
  myFont1 = createFont("CourierNewPS-BoldItalicMT", 32);
  String s = String.valueOf(da)+"-"+String.valueOf(mo)+"-"+String.valueOf(ye)+"-"+String.valueOf(ho)+"-"+String.valueOf(m);
  s="Grasprehabilitator_data_"+s+".txt";
  output = createWriter(s);
  noStroke();
  fill(0);
  frameRate(135);
}

void draw() 
{
background(#75778B);  
frontpage();
readdata();
textinpage();
buttons();
if(!started)t=millis();
if(started)
{
anim();
baar();
filewriter();
prevlf=lf;
prevgrip = grip;
lfrprev = lfr;
griprprev = gripr;
print = true;
   u++;
}
}

void keyPressed()
{
  if(key == 'x')
  {
   s1=!s1; 
  }
 if(eval){evaluate();}
}

//void update() {
//if (overRect() ) {
//    rectOver = true;
//  } else {
//rectOver = false;
//  }
//}

//boolean overRect()  {
//  if (mouseX >= 25 && mouseX <= 175 && 
//      mouseY >= 25 && mouseY <= 75) {
//    return true;
//  } else {
//    return false;
//  }
//}
  