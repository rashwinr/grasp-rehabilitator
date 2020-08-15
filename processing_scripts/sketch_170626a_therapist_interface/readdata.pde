
void readdata()
{
  if(myPort.available()>=0) 
  {
    String inputString = myPort.readStringUntil('\n');
    if (inputString != null)
    {
            String [] inputStringArr = split(inputString, ",");
            if(inputStringArr.length>3)
            {
            lf=(float(trim(inputStringArr[1])))/100;
            if(!started)c = lf;
            if(started)lf = c-lf;
            if(lf<=0)lf = 0.0;
            if(started)
            {
            gf1=(float(trim(inputStringArr[2])))/100;
            gf2=(float(trim(inputStringArr[3])))/100;
            grip=(gf1+gf2)/2;
            lfr = 50.0*(lf - prevlf);
            lfr = update(lfr,varprocl,varmeasl,lfrprev,lfrnoise);
            gripr = 50.0* (grip - prevgrip);
            gripr = update(gripr,varprocg,varmeasg,griprprev,gfrnoise);
            if(lfr<=0)lfr = 0.0;
            if(gripr<=0)gripr=0.0;
            }
            }    
       }
    }
}