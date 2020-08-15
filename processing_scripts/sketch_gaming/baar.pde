//float alf,alfr,agf,agfr;
//float anlf,anlfr,angf,angfr;
//float nlf,nlfr,ngfr,ngf;

void baar()
{
 noFill();
 stroke(0,0,0,105);
 strokeWeight(2);
 int wi= width/25;
 float he =2.5*height/400;
 rect(width/2 - width/2.2 - wi/2,height/2 - height/4,wi,height*2.5/4);
 rect(width/2 + width/2.2 - wi/2,height/2 - height/4,wi,height*2.5/4);
 if(!w)
 {
 rect(width/2 - width/3 -wi/2,height/2 - height/4,wi,height*2.5/4);
 rect(width/2 + width/3 -wi/2,height/2 - height/4,wi,height*2.5/4);
 }

if(w)                                               //normal mode
{
 for(int i=0;i<ngfr;i++)            // GFR normal
 {
 stroke(0+(i*2.5),255-(i*2.5),5,200);
 fill(color(0+(i*2.5),255-(i*3),5,200));
 strokeWeight(2);
 rect(width/2 - width/2.2 - wi/2,3.5*height/4-(he*i),wi,-he);
 }
  for(int i=0;i<nlfr;i++)          // LFR normal
 {
 stroke(0+(i*2.5),255-(i*3),5,200);
 fill(color(0+(i*2.5),255-(he*3),5,200));
 strokeWeight(2);
 rect(width/2 + width/2.2 - wi/2,3.5*height/4-(he*i),wi,-he);
 }
}
 if(!w)                                              //affected mode
 {
  for(int i=0;i<alfr;i++)           //LFR affected
 {
 stroke(0+(i*2.5),255-(i*3),5,200);
 fill(color(0+(i*2.5),255-(i*3),5,200));
 strokeWeight(2);
 rect(width/2 + width/3 -wi/2,3.5*height/4-(he*i),wi,-he);
 }
 
   for(int i=0;i<agfr;i++)          //GFR affected
 {
 stroke(0+(i*2.5),255-(i*2.5),5,200);
 fill(color(0+(i*2.5),255-(i*3),5,200));
 strokeWeight(2);
 rect(width/2 - width/3 -wi/2,3.5*height/4-(he*i),wi,-he);
 }
 println(npgfrfinal);
  for(int i=0;i<npgfrfinal;i++)            // GFR normal
 {
 stroke(0+(i*2.5),255-(i*2.5),5,200);
 fill(color(0+(i*2.5),255-(i*3),5,200));
 strokeWeight(2);
 rect(width/2 - width/2.2 - wi/2,3.5*height/4-(he*i),wi,-he);
 }
  println(nplfrfinal);
  for(int i=0;i<nplfrfinal;i++)          // LFR normal
 {
 stroke(0+(i*2.5),255-(i*3),5,200);
 fill(color(0+(i*2.5),255-(i*3),5,200));
 strokeWeight(2);
 rect(width/2 + width/2.2 - wi/2,3.5*height/4-he*i,wi,-he);
 }
  //for(int i=0;i<ngfr;i++)            // GFR normal
 {//
 //s//troke(0+(i*2.5),255-(i*2.5),5,200);
 //f//ill(color(0+(i*2.5),255-(i*3),5,200));
 //s//trokeWeight(2);
 //r//ect(width/2 - width/2.2 - wi/2,3.5*height/4-(he*i),wi,-he);
 //}//
  //for(int i=0;i<nlfr;i++)          // LFR normal
 //{//
 //s//troke(0+(i*2.5),255-(i*3),5,200);
 //f//ill(color(0+(i*2.5),255-(he*3),5,200));
 //s//trokeWeight(2);
 //r//ect(width/2 + width/2.2 - wi/2,3.5*height/4-(he*i),wi,-he);
 //}//
 }
 
  for(int i=0;i<100;i++)           //color coded reference
 {
 stroke(0+(i*2.5),255-(i*2.5),5,50);
 fill(color(0+(i*2.5),255-(i*3),5,50));
 rect(width/2 - width/2.2 - wi/2 + 0.06*width,3.5*height/4 - (he*i),20,-he);
 rect(width/2 + width/2.2 - wi/2 - 0.06*width,3.5*height/4 - (he*i),20,-he);
 }
 
 for(int i=0;i<=100;i+=25)          //text for lFR and gFR
 {
   fill(0);
   textFont(myFont, 20);
   textAlign(CENTER);
   text(i,width/2 - width/2.2 + wi/2 + 0.06*width,3.5*height/4 - he*i);
   text(i,width/2 + width/2.2 + wi/2 - 0.06*width,3.5*height/4 - he*i);
 }
 

}
}