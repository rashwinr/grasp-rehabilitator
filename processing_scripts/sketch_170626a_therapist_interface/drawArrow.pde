void drawArrow(int cx, int cy, int len, float angle)
{
  pg.pushMatrix();
  pg.translate(cx, cy);
  pg.rotate(radians(angle));
  pg.line(0,0,len, 0);
  pg.line(len, 0, len - 8, -8);
  pg.line(len, 0, len - 8, 8);
  pg.popMatrix();
}