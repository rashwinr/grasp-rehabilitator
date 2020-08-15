unsigned long sampleInterval = 1000/60;
unsigned long sampleTimer;
float varmeasl=0.1910788165, varmeasg1=0.0249017, varmeasg2=0.000033705, varprocl = 1.00E-2, varprocg2 = 1.00E-5, varprocg1 = 1.00E-2;
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
int a3 = analogRead(2);
int a4 = analogRead(3);
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
// -0.0009    2.2938  -29.9389
float lf = -0.0009*ul*ul+2.2938*ul-29.9389;      //calibration lift force sensor 1.
lf = constrain(lf,0.00,1500.00);
lf*=9.81/10.0;
//-0.0012    2.3855  -27.2167
float gf1 =-0.0012*ug1*ug1+2.3855*ug1-27.2167;    //calibration grasp force sensor 1.
gf1 = constrain(gf1,0.00,1500.00);
gf1*=9.81/10.0;
//-0.0015    2.3300  -42.4562
float gf2 = -0.0015*ug2*ug2+2.3300*ug2-42.4562;    //calibration grasp force sensor 2.
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
