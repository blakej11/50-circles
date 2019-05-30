/*
 * Sand dollars.
 */
void circle(float X, float Y, float R) {
  final int nrings = int(random(1, 4.99));
  final float objdiam = R / (float(nrings) * 4);

  pushMatrix();
  translate(X, Y);
  stroke(255);
  noFill();
  ellipse(0, 0, 2 * R, 2 * R);

  for (int i = 1; i <= nrings; i++) {
    final int nobj = int(random(5, 20));
    final float r = R * float(i) / float(nrings + 1);
    final float c = random(64, 255);
    final float thisobj = random(objdiam / 2, objdiam);
    final float height = random(0.25, 2) * thisobj;

    rotate(random(TWO_PI));
    fill(c);
    stroke(c);

    for (int j = 0; j < nobj; j++) {
      rotate(TWO_PI / float(nobj));
      ellipse(r, 0, thisobj, height);
    }
    if (random(1) > 0.5) {
      noFill();
      ellipse(0, 0, 2 * r, 2 * r);
    }
  }

  popMatrix();
}
