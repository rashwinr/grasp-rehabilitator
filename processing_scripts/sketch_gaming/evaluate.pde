float[] nplfr = new float[15];
float[] npgf = new float[15];
float[] npgfr = new float[15];
float nplfrfinal,npgfrfinal,npgffinal;
int u1=0,u2=0,u3=0;
void evaluate()
{
  //println(c);
  for(int q =1;q<10000;q++)
  {
    if(u1<=14 && u2<=14 && u3<=14)
    {
    if((normallf[q]<= c) && (normallfr[q]<=normallfr[q-1]-1) && (normallfr[q-1]>0.0))
    {
      nplfr[u1] = (float)normallfr[q-1];
      u1++;
    }
    if(normallf[q] <= c && normallf[q]>=0 && normalgfr[q]<normalgfr[q-1]-2)
    {
      npgfr[u2] = normalgfr[q-1];
      u2++;
    }
    if(normallf[q] <= c && normallf[q]>=0 && normalgf[q]<normalgf[q-1]-1)
    {
      npgf[u3] = normalgf[q-1];
     // println(npgf[u3]);
      u3++;
    }
    }
  }
  u1=0;
  u2=0;
  u3=0;
  nplfr = reverse(sort(nplfr));
  npgfr = reverse(sort(npgfr));
  normalgf = reverse(sort(normalgf));
  //println(nplfr);
  //println("Done");
  //println(npgfr);
  for (int i = 1;i<10;i++)nplfrfinal += nplfr[i];
  nplfrfinal = nplfrfinal/6;
  println(nplfrfinal);
 for (int i = 1;i<10;i++)npgfrfinal += npgfr[i];
  npgfrfinal = npgfrfinal/6;
    println(npgfrfinal);
  for (int i = 1;i<10;i++)npgffinal += normalgf[i];
  npgffinal = npgffinal/6;
      println(npgffinal);
}