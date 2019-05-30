/*
 * Snowballs.
 */
void circle(float X, float Y, float R) {
  final int ncirc = int(random(64, 512));

  noStroke();
  fill(255, 1024 / float(ncirc));
  pushMatrix();
  translate(X, Y);
  for (int i = 0; i < ncirc; i++) {
    final float cr = random(0, R);
    final float ct = random(TWO_PI);
    final float cR = random(0, R - cr);
    ellipse(cr * cos(ct), cr * sin(ct), 2 * cR, 2 * cR);
  }

  popMatrix();
}
