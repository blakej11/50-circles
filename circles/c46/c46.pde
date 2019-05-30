/*
 * A tangle of overlapping spirals.
 */
void spiral(float X, float Y, float R, float turns) {
  final float points_per_cycle = 100;
  final float dtheta = TWO_PI / points_per_cycle * (random(1) < 0.5 ? -1 : 1);
  final float dr = R / (points_per_cycle * turns);
  float theta;

  pushMatrix();
  translate(X, Y);

  beginShape();
  curveVertex(0, 0);
  theta = random(TWO_PI);
  for (float r = 0; r < R; r += dr) {
    curveVertex(r * cos(theta), r * sin(theta));
    theta += dtheta;
  }
  endShape();

  popMatrix();
}

void circle(float X, float Y, float R) {
  final int nspirals = int(random(3, 50));
  noFill();
  stroke(255, max(512 / nspirals, 64));
  for (int i = 0; i < nspirals; i++) {
    spiral(X, Y, R, 100 / float(nspirals) + int(random(-1, 1.9)));
  }
}
