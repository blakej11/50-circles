/*
 * Shards of concentric circles.
 */
void circle(float X, float Y, float R) {
  float D = 2 * R;
  final float density = random(R / 20, R / 10);

  pushMatrix();
  translate(X, Y);
  stroke(255);
  noFill();
  for (float d = 0; d < D; d += density) {
    final float a1 = random(TWO_PI), a2 = random(TWO_PI);
    rotate(random(TWO_PI));
    arc(0, 0, d, d, min(a1, a2), max(a1, a2));
  }
  popMatrix();
}
