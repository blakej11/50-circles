/*
 * Circular maze. May or may not be solvable.
 */
void circle(float X, float Y, float R) {
  float D = 2 * R;
  final float density = D / random(10, 30);
  final float holewidth = 15;

  pushMatrix();
  translate(X, Y);
  stroke(255);
  noFill();
  for (float d = density; d <= D; d += density) {
    float oa, a;
    rotate(random(TWO_PI));

    final int holes = int(random(2, 8.99));
    oa = 0;
    for (int h = 0; h < holes; h++) {
      a = random(oa, float(h + 1) / float(holes));
      arc(0, 0, d, d, oa * TWO_PI, a * TWO_PI - holewidth / d);
      oa = a;
    }
    arc(0, 0, d, d, oa * TWO_PI, TWO_PI);

    if (d + density <= D) {
      final int bars = int(random(2, 8.99));
      for (int b = 0; b < bars; b++) {
        rotate(random(TWO_PI));
        line(d / 2, 0, (d + density) / 2, 0);
      }
    }
  }
  popMatrix();
}
