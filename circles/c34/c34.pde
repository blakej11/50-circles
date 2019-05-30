/*
 * Hair scrunchies. Also kinda like eye filaments.
 */
void circle(float X, float Y, float R) {
  final float jangle = random(5, 35);

  pushMatrix();
  translate(X, Y);
  noFill();
  stroke(255, 32);

  for (float i = 0; i < 50; i++) {
    rotate(random(TWO_PI));
    beginShape();
    for (float j = 0; j < R; j++) {
      final float theta = TWO_PI * j / R;
      final float cr = random(R * (1 - jangle/R), R * (1 + jangle/R));
      curveVertex(cr * cos(theta), cr * sin(theta));
    }
    endShape(CLOSE);
  }

  popMatrix();
}
