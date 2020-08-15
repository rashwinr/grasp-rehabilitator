import processing.serial.*;
import java.util.Date;
Serial myPort;
PGraphics pg;
PrintWriter output;
final String serialPort = "COM8";
int SIZEX=1650;
int SIZEY=1050;
PFont myFont,myFont1;
  int da = day();    // Values from 1 - 31
  int mo = month();  // Values from 1 - 12
  int ye = year();   // 2003, 2004, 2005, etc.
  int s = second(); 
  int m = minute(); 
  int ho = hour(); 
boolean print = false;
float Pc = 0.0, G = 0.0, Xp = 0.0, Zp = 0.0, Xe = 0.0;
int rectX=25, rectY=25;      // Position of button
color rectHighlight = #18DB37, circleHighlight = #D32D54;
color currentColor=#B7B5AE;
boolean rectOver = false;
boolean started = false;
int i=0, ij=0,k=0, t=0,t1=0,f=0, e=0;
float lf=0.0,gf1=0.0,gf2=0.0,prevlf=0.0,grip=0.0, prevgrip=0.0,c=0.0;
float lfr=0.0,lfrprev = 0.0,gripr,griprprev,lfrnoise=1.0,gfrnoise=1.0; 
float varprocl=1E-3,varmeasl=0.015080;
float varprocg=1E-4,varmeasg=0.00371;

void setup()
{
  myPort = new Serial(this,serialPort, 250000);
  delay(10);
  myPort.clear();
  fullScreen(P3D);
  int x=floor(width/1.15), y =  floor(height/1.5);
  pg = createGraphics(x,y);
  smooth(2);
  //String[] fontList = PFont.list();
  //printArray(fontList);
  myFont = createFont("HelveticaNeue-Bold", 32);
  myFont1 = createFont("CourierNewPS-BoldItalicMT", 32);
  String s = String.valueOf(da)+"-"+String.valueOf(mo)+"-"+String.valueOf(ye)+"-"+String.valueOf(ho)+"-"+String.valueOf(m);
  s="Grasprehabilitator_data_"+s+".txt";
  output = createWriter(s);
  noStroke();
  fill(0);
  frameRate(1000);
  pg.beginDraw();
  pg.background(#D6D8D8);
}

void draw() 
{
background(#75778B);  
  image(pg,width/15,height/10);
readdata();
textinpage();
buttons();
if(started)
{
legend();
drawplot();
filewriter();
prevlf=lf;
prevgrip = grip;
lfrprev = lfr;
griprprev = gripr;
print = true;
}
}