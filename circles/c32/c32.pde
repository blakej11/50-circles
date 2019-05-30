/*
 * Bicycle wheels.
 */
void bicycle(float X, float Y, float R, int nrings, int spokes, int skip) {
  pushMatrix();
  translate(X, Y);
  noFill();
  stroke(255);
  rotate(random(TWO_PI));
  ellipse(0, 0, 2 * R, 2 * R);

  for (int ring = 0; ring < nrings; ring++) {
    final float r = R * random(0.4, 0.7);

    ellipse(0, 0, 2 * r, 2 * r);
    for (int i = 0; i < spokes; i++) {
      int delta = ((((i / 2) % 2) == 0) ? 1 : -1) * skip;
      float stheta = (float(i) / float(spokes)) * TWO_PI;
      float etheta = (float(i + delta) / float(spokes)) * TWO_PI;
      float dtheta = (stheta + etheta) / 2;
      line(R * cos(stheta), R * sin(stheta), r * cos(dtheta), r * sin(dtheta));
      line(r * cos(dtheta), r * sin(dtheta), R * cos(etheta), R * sin(etheta));
    }

    R = r;
  }

  popMatrix();
}

void circle(float X, float Y, float R) {
  final int nrings = int(random(1, 6.99));			// 1
  final float spokes = random(20, 50);
  final int ispokes = int(spokes);				// 36
  final int skip = int(random(spokes / 5, spokes / 2.5));	// 10

  bicycle(X, Y, R, nrings, ispokes, skip);
}
