float time;
void textinpage()
{

    textFont(myFont,32);
    textAlign(LEFT, TOP);
    fill(#C1AC65);
    text("Grasp Rehabilitator Therapist User-interface",width/2 -400,30); 
    textFont(myFont,24);
    textAlign(LEFT, TOP);
    fill(#000000);
    text(ho+":"+m+":"+s, width*7/10,height*8/10);
    text("Sampling rate: " + (int)frameRate,width*7/10,height*8/10 +30);
    if(started){time = (t1-t)/1000;}
    text("Time elapsed: "+ time, width*7/10,height*8/10 +60);
}