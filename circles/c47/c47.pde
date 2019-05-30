/*
 * Constellations.
 */

void star(float R) {
  final float r = sqrt(random(R * R));
  final float theta = random(TWO_PI);
  final float x = r * cos(theta);
  final float y = r * sin(theta);
  final float nlines = random(20, 100);

  stroke(255, 2000 / nlines);
  for (int i = 0; i < nlines; i++) {
    final float ntheta = random(TWO_PI);
    line(x, y, R * cos(ntheta), R * sin(ntheta));
  }
}

void circle(float X, float Y, float R) {
  final int nstars = int(random(5, 20));

  pushMatrix();
  translate(X, Y);
  stroke(255, 16);
  noFill();
  ellipse(X, Y, 2 * R, 2 * R);
  for (int i = 0; i < nstars; i++) {
    star(R);
  }
  popMatrix();
}
