/*
 * Sine waves radiating from the center of a circle.
 */
void circle(float X, float Y, float R) {
  final float Rincr = R * 0.01;

  noFill();
  pushMatrix();
  translate(X, Y);

  for (int i = 0; i < 100; i++) {
    rotate(random(2 * PI));

    beginShape();
    for (float r = 0; r < R; r += Rincr) {
      curveVertex(r, (R / 10) * sin((r * TWO_PI * 10) / (R * 2)));
    }
    endShape();
  }

  popMatrix();
}
