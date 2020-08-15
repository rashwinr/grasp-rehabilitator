float update(float val, float varProcess, float varmeas, float prev, float noise) {  
  Pc = noise + varProcess;
  G = Pc/(Pc + varmeas);
  noise = (1-G)*Pc;
  Xp = prev;
  Zp = Xp;
  Xe = G*(val-Zp)+Xp;
  return(Xe);
}