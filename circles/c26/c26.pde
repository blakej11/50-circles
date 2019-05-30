/*
 * Jangly growth rings.
 */
void circle(float X, float Y, float R) {
  final float rings = int(random(5, 15.99));
  final float jangle = 75 / rings;

  pushMatrix();
  translate(X, Y);
  noFill();

  for (float i = 0; i < rings; i++) {
    final float r = i * R / rings;
    rotate(random(TWO_PI));
    beginShape();
    for (float j = 0; j < r; j++) {
      final float theta = TWO_PI * j / r;
      final float cr = random(r * (1 - jangle/r), r * (1 + jangle/r));
      curveVertex(cr * cos(theta), cr * sin(theta));
    }
    endShape(CLOSE);
  }

  popMatrix();
}
