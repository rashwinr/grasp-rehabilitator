import g4p_controls.*;
import java.awt.*;
import java.awt.Font;
import processing.sound.*;
import processing.serial.*;


Serial myPort;
PGraphics pg;
PrintWriter output;
final String serialPort = "COM8";
GTextField subjectidinput,instructorinitials;
GLabel subjectid,sessionno,title,instructor;
GButton startbutton;
GDropList sessionnoinput; 
GOption grp1_a,grp1_b,grp1_c,grp1_d,grp2_a,grp2_b,grp2_c,grp2_d;
GTabManager tt;
GToggleGroup tg1,tg2;
GImageToggleButton Start;
SoundFile soundfile, sound;
String filename, Weight, Texture, Subject, Instruct, Session;
int da = day();    // Values from 1 - 31
int mo = month();  // Values from 1 - 12
int ye = year();   // 2003, 2004, 2005, etc.
int s = second(); 
int m = minute(); 
int ho = hour(); 
int x,y;
boolean started = false;


public void setup() {
  myPort = new Serial(this,serialPort, 250000);
frameRate(800);
delay(10);
fullScreen();
x = floor(width);
y =  floor(height);
G4P.setGlobalColorScheme(GCScheme.BLUE_SCHEME);
G4P.setCursor(ARROW);
  
soundfile = new SoundFile(this, "Beep.aiff");
    
subjectidinput = new GTextField(this, .45*x,0.1*y, 250, 25);
subjectidinput.setFont(new Font("Times New Roman", Font.ITALIC, 18));
subjectidinput.tag = "subjectidinput";
subjectidinput.setPromptText("Please enter Subject ID here");

instructorinitials = new GTextField(this, .48*x,0.5*y, 300, 25);
instructorinitials.setFont(new Font("Times New Roman", Font.ITALIC, 18));
instructorinitials.tag = "instructorinput";
instructorinitials.setPromptText("Please enter Instructor initials here");

String s = String.valueOf(da)+"-"+String.valueOf(mo)+"-"+String.valueOf(ye)+"-"+String.valueOf(ho)+"-"+String.valueOf(m);
filename ="/saveddata/Grasprehabilitator_data_"+s;
tt = new GTabManager();
tt.addControls(subjectidinput,instructorinitials);
createGUI();

}

public void draw() {

background(#B7BBF2);
text(str(frameRate),10,10);
stroke(0);
strokeWeight(2);
if(started)
{
  //started.setVisible(false);
}
  
}

public void createGUI()
{
  
title = new GLabel(this, 0.3*x,0.02*y,0.4*x,50);
title.setFont(new Font("Times New Roman", Font.BOLD, 24));
title.setText("Gasp Rehabilitation Device Data Acquisition Software",GAlign.CENTER, GAlign.MIDDLE);  
  
subjectid = new GLabel(this, 0.4*x,0.1*y,200,20);
subjectid.setFont(new Font("Times New Roman", Font.BOLD, 18));
subjectid.setText("Subject ID:",GAlign.LEFT, GAlign.MIDDLE);  
  
 

sessionno = new GLabel(this, 0.4*x,0.15*y,200,20);
sessionno.setFont(new Font("Times New Roman", Font.BOLD, 18));
sessionno.setText("Session No:",GAlign.LEFT, GAlign.MIDDLE);  
  
sessionnoinput = new GDropList(this,.45*x,0.15*y, 120, 110, 5);
sessionnoinput.setFont(new Font("Times New Roman", Font.PLAIN, 18));
sessionnoinput.setItems(loadStrings("list.txt"), 0);
  
GToggleGroup tg1 = new GToggleGroup();
GToggleGroup tg2 = new GToggleGroup();
 
grp1_a = new GOption(this, 0.3*x, 0.3*y, 120, 20);
grp1_a.setFont(new Font("Times New Roman", Font.PLAIN, 18));
grp1_a.setText("W1",GAlign.LEFT, GAlign.MIDDLE);
grp1_b = new GOption(this, 0.3*x, 0.33*y, 120, 20);
grp1_b.setFont(new Font("Times New Roman", Font.PLAIN, 18));
grp1_b.setText("W2",GAlign.LEFT, GAlign.MIDDLE);
grp1_c = new GOption(this, 0.3*x, 0.36*y, 120, 20);
grp1_c.setFont(new Font("Times New Roman", Font.PLAIN, 18));
grp1_c.setText("W3",GAlign.LEFT, GAlign.MIDDLE);
grp1_d = new GOption(this, 0.3*x, 0.39*y, 120, 20);
grp1_d.setFont(new Font("Times New Roman", Font.PLAIN, 18));
grp1_d.setText("W4",GAlign.LEFT, GAlign.MIDDLE);
grp2_a = new GOption(this, 0.6*x, 0.3*y, 120, 20);
grp2_a.setFont(new Font("Times New Roman", Font.PLAIN, 18));
grp2_a.setText("T1",GAlign.LEFT, GAlign.MIDDLE);
grp2_b = new GOption(this, 0.6*x, 0.33*y, 120, 20);
grp2_b.setFont(new Font("Times New Roman", Font.PLAIN, 18));
grp2_b.setText("T2",GAlign.LEFT, GAlign.MIDDLE);
grp2_c = new GOption(this, 0.6*x, 0.36*y, 120, 20);
grp2_c.setFont(new Font("Times New Roman", Font.PLAIN, 18));
grp2_c.setText("T3",GAlign.LEFT, GAlign.MIDDLE);
grp2_d = new GOption(this, 0.6*x, 0.39*y, 120, 20);
grp2_d.setFont(new Font("Times New Roman", Font.PLAIN, 18));
grp2_d.setText("T4",GAlign.LEFT, GAlign.MIDDLE);

tg1.addControls(grp1_a, grp1_b, grp1_c, grp1_d);
tg2.addControls(grp2_a, grp2_b, grp2_c, grp2_d);
  
instructor = new GLabel(this, 0.4*x,0.5*y,200,20);
instructor.setFont(new Font("Times New Roman", Font.BOLD, 20));
instructor.setText("Instructor initials: ",GAlign.LEFT, GAlign.MIDDLE);  

Start = new GImageToggleButton(this,0.4*x,0.7*y,"I123.png",2,1);
//Start.setFont(new Font("Times New Roman", Font.BOLD, 20));
Start.tag = "start";
  
}

public void handleToggleControlEvents(GToggleControl source, GEvent event) { 
  if (source == grp1_a) {
    Weight = "W1";

  } else if (source == grp1_b) {
    Weight = "W2";

  } else if (source == grp1_c) {
    Weight = "W3";

  } else if (source == grp1_d) {
    Weight = "W4";

  }
  else if (source == grp2_a) {
    Texture = "T1";

  }
  else if (source == grp2_b) {
    Texture = "T2";

  }
  else if (source == grp2_c) {
    Texture = "T3";
  }
  else if (source == grp2_d) {
    Texture = "T4";
  }
}

public void handleTextEvents(GEditableTextControl textControl, GEvent event) { 
//if(textControl == subjectidinput)// String Subject = 
//if(textControl == instructorinitials) //String Instruct = 
}


public void handleDropListEvents(GDropList list, GEvent event) {
  
  if (list == sessionnoinput){
    Session = list.getSelectedText();
    
  }
}

public void handleToggleButtonEvents(GImageToggleButton button, GEvent event) { 
//  println(Start.getState());
  if(button == Start && event == GEvent.CLICKED && Start.getState()==0)
  {
    soundfile.play();
    Subject = subjectidinput.getText();
    Instruct = instructorinitials.getText();
    filename = filename+"-"+Session+"-"+"_"+Subject+"_"+Instruct+"_"+Weight+"_"+Texture+".txt";
    output = createWriter(filename);
    started = true;
  }
   if(button == Start && event == GEvent.CLICKED && Start.getState()==1)
  {
    soundfile.play();
    output.flush();  // Writes the remaining data to the file
    output.close();
    started = false;
  }
}


//Weight, Texture, Subject, Instruct, Session;