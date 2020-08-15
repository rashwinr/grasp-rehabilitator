float time;
void textinpage()
{
    pushMatrix();
    textFont(myFont,32);
    textAlign(LEFT, TOP);
    fill(#C1AC65);
    //text("Grasp Rehabilitator Gaming-interface",width/2 -400,30); 
    textFont(myFont,24);
    textAlign(LEFT, TOP);
    fill(#000000);
    text(ho+":"+m+":"+s, width*2/10,height*9/10+60);
    text("Sampling rate: " + (int)frameRate,width*4/10,height*9/10+60);
    t1=millis();
    if(started){time = (t1-t)/1000;}
    text("Time elapsed: "+ time, width*7/10,height*9/10+60);
    popMatrix();
}