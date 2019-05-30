/*
 * Sine waves radiating from the center of a circle, with increasing magnitude
 * as they go out, and light-weight strokes.
 */
void circle(float X, float Y, float R) {
  final float minmag = R / 25;
  final float maxmag = random(R / 5);
  final float minwig = R / 40;
  final float maxwig = random(R / 5);
  final float Rincr = R / 100;

  noFill();
  stroke(192, 32);
  
  pushMatrix();
  translate(X, Y);

  for (int i = 0; i < 1000; i++) {
    final float mag = random(minmag, maxmag);
    final float wiggles = random(minwig, maxwig);

    rotate(random(TWO_PI));

    beginShape();
    for (float r = 0; r < R; r += Rincr) {
      curveVertex(r, (r / R) * mag * sin((r * TWO_PI * wiggles) / (R * 2)));
    }
    endShape();
  }

  popMatrix();
}
