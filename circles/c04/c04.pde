/*
 * Each circle has three inner circles, recursively,
 * but each set is at its own rotation.
 */
void circle(float x, float y, float r) {
  pushMatrix();
  translate(x, y);
  rotate(random(2 * PI));
  noFill();
  ellipse(0, 0, 2 * r, 2 * r);
  if (r > 3) {
    float nr = r / 2;
    circle(nr * cos( 3 * PI / 6), nr * sin( 3 * PI / 6), nr);
    circle(nr * cos( 7 * PI / 6), nr * sin( 7 * PI / 6), nr);
    circle(nr * cos(11 * PI / 6), nr * sin(11 * PI / 6), nr);
  }
  popMatrix();
}
