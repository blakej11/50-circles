/*
 * Solar system.
 */
void circle(float X, float Y, float R) {
  final int nrings = int(random(1, 9.99));
  final float objdiam = R / (float(nrings) * 4);

  pushMatrix();
  translate(X, Y);

  stroke(255, 64);
  for (int i = 0; i < R * 3; i++) {
    final float theta = random(TWO_PI);
    final float r = random((R / float(nrings)) / 4);
    line(0, 0, r * cos(theta), r * sin(theta));
  }
  
  for (int i = 1; i <= nrings; i++) {
    final float r = R * float(i) / float(nrings);
    final float c = random(64, 255);
    final float thisobj = random(objdiam / 2, objdiam);
    final float height = random(0.25, 2) * thisobj;
    final int nobj = int(random(5, 20));
    final float eccen = random(0.25, 1);

    rotate(random(TWO_PI));
    stroke(c);

    noFill();
    ellipse(0, 0, 2 * r, 2 * r * eccen);

    fill(c);
    for (int j = 0; j < nobj; j++) {
      final float theta = TWO_PI * float(j) / float(nobj);
      ellipse(r * cos(theta), eccen * r * sin(theta), thisobj, height);
    }
  }

  popMatrix();
}
