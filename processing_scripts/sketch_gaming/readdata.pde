
void readdata()
{
  if(myPort.available()>=0) 
  {
    String inputString = myPort.readStringUntil('\n');
    if (inputString != null)
    {
      //print(inputString);
            String [] inputStringArr = split(inputString, ",");
            if(inputStringArr.length == 4)
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
            lfr = Kalman(lfr,varprocl,varmeasl,lfrprev,lfrnoise);
            gripr = 50.0* (grip - prevgrip);
            gripr = Kalman(gripr,varprocg,varmeasg,griprprev,gfrnoise);
            if(lfr<=0)lfr = 0.0;
            if(gripr<=0)gripr=0.0;
            }
            }    
       }
    }
    
    if(!w)
    {
        alfr = lfr;
        agfr = gripr;
        agf = grip;
        alf = lf;
        affectedlfr[u] = lfr;
        affectedlf[u] = lf;
        affectedgf[u] = grip;
        affectedgfr[u] = gripr;
    }
        if(w)
    {
        nlfr = lfr;
        ngfr = gripr;
        ngf = grip;
        nlf = lf;
        normallfr[u] = lfr;
        normallf[u] = lf;
        normalgf[u] = grip;
        normalgfr[u] = gripr;
       // println(normallfr[u]);
    }
   //println(u);
    }