float liftf, gf1, gf2, pgf1,pgf2,pliftf;
unsigned long sampleInterval = 1000/60;
unsigned long sampleTimer;
float l,g1,g2,lpre,g1pre,g2pre;

void setup() {
  // put your setup code here, to run once:
  Serial.begin(115200);
  pinMode(2, INPUT);
  pinMode(3, INPUT);
  pinMode(4, INPUT);
}

void loop() {
  // put your main code here, to run repeatedly:
    unsigned long currMillis = millis();  
  if(currMillis - sampleTimer >= sampleInterval)  // is it time for a sample?
{
sampleTimer = currMillis; 
  l = (0.1231*lpre)+(0.8769*analogRead(2));
  l = map(l,225,419,0,500);
  l = constrain(l,0,10000);
  g1 = (0.1231*g1pre)+(0.8769*analogRead(3));
  g2 = (0.1231*g2pre)+(0.8769*analogRead(4));
  g2 = g2*1.4231-36.511;
  g2 = constrain(g2,0,10000);
  Serial.print(g2);
  Serial.print(",");
  Serial.print(g1);
  Serial.print(",");
  Serial.println(l);
}
lpre = l;
g1pre = g1;
g2pre = g2;
}
