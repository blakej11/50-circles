/*
 * Jangly growth rings -> reminiscent of a dandelion.
 */
void circle(float X, float Y, float R) {
  final float jangle = random(5, 15);

  pushMatrix();
  translate(X, Y);
  noFill();
  stroke(128, 64);

  for (float i = 0; i < R; i++) {
    final float r = random(R * 0.05, R * 0.95);
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
