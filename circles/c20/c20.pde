/*
 * Simple spiderweb - lines from side to side.
 */
void circle(float X, float Y, float R) {
  final int nthreads = int(random(R / 4, R * 2));

  pushMatrix();
  translate(X, Y);
  stroke(map(nthreads, R / 4, R * 2, 255, 64), 128);

  for (int i = 0; i < nthreads; i++) {
    final float t1 = random(TWO_PI);
    final float t2 = random(TWO_PI);
    line(R * cos(t1), R * sin(t1), R * cos(t2), R * sin(t2));
  }
  popMatrix();
}
