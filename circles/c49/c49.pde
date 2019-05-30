/*
 * Rubber band ball.
 */
void circle(float X, float Y, float R) {

  pushMatrix();
  translate(X, Y);
  noFill();

  final int narcs = int(random(30, 800)); // number of arcs
  for (int i = 0; i < narcs; i++) {
    final float x = random(0, R);
    final float r = random(R - x, R + x);
    final float arclen = acos((sq(r) + sq(x) - sq(R)) / (2 * r * x));
    final float theta = random(TWO_PI);
    final float weight = random(0.5, 3);

    strokeWeight(weight);
    stroke(255, 10000 / (weight * narcs));
    rotate(theta);
    arc(x, 0, 2 * r, 2 * r, PI - arclen, PI + arclen);
    rotate(-theta);
  }

  strokeWeight(1);
  popMatrix();
}
