unsigned long sampleInterval = 1000/60;
unsigned long sampleTimer;
float varmeasl=0.9828712076, varmeasg1=0.23495, varmeasg2=0.033705, varprocl = 0.25, varprocg2 = 1.00E-2, varprocg1 = 1.00E-1;
float Pc = 0.0, G = 0.0, noise = 1.0, Xp = 0.0, Zp = 0.0, Xe = 0.0, ul=0.0, ug1=0.0, ug2=0.0;
float lp=1.0,gp1=1.0,gp2=1.0;

void setup() {
  // put your setup code here, to run once:
Serial.begin(115200);
}

void loop() {
  // put your main code here, to run repeatedly:
    unsigned long currMillis = millis();
if(currMillis - sampleTimer >= sampleInterval)  // is it time for a sample?
{
sampleTimer = currMillis; 
int a2=analogRead(4);
int a3 = analogRead(3);
int a4 = analogRead(2);
//Serial.print(a2);
//Serial.print(", ");
//Serial.print(a3);
//Serial.print(", ");
//Serial.print(a4);
//Serial.print(", ");
ul = Kalmanfilter(a2,varprocl,varmeasl,ul,lp);
lp=noise;
ug1 = Kalmanfilter(a3,varprocg1,varmeasg1,ug1,gp1);
gp1=noise;
ug2 = Kalmanfilter(a4,varprocg2,varmeasg2,ug2,gp2);
gp2=noise;
//Serial.print(ul);
//Serial.print(", ");
//Serial.print(ug1);
//Serial.print(", ");
//Serial.print(ug2);
// -0.0021 2.6860 -24.8088
float lf = -0.0021*ul*ul+2.6860*ul-34.8088;      //calibration lift force sensor 1.
lf = constrain(lf,0.00,1500.00);
lf*=9.81/10.0;
//-0.0005 1.6659 -6.0253
float gf1 =-0.0005*ug1*ug1+1.6659*ug1-16.0253;    //calibration grasp force sensor 1.
gf1 = constrain(gf1,0.00,1500.00);
gf1*=9.81/10.0;
//-0.0005 1.54 -79.3866
float gf2 = -0.0005*ug2*ug2+1.54*ug2-78.3866;    //calibration grasp force sensor 2.
gf2 = constrain(gf2,0.00,1500.00);
gf2*=9.81/10.0;
//Serial.print(",");
Serial.print(lf);
Serial.print(",");
Serial.print(gf1);
Serial.print(",");
Serial.println(gf2);
  }
}


float Kalmanfilter(float val, float varProcess, float varmeas, float prev, float no) {  
  Pc = no + varProcess;
  G = Pc/(Pc + varmeas);
  noise = (1-G)*Pc;
  Xp = prev;
  Zp = Xp;
  Xe = G*(val-Zp)+Xp; // Update
  return(Xe);
}
