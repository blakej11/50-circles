/*
 * A hairy spiral.
 */
void spiral(float R, int maxlen, float maxdt, float maxdr) {
  noFill();
  stroke(255, 300 / maxlen);

  for (int lines = 0; lines < 200 * sqrt(R); lines++) {
    float r, theta;

    beginShape();

    r = random(R * 0.9, R * 1.1);
    theta = random(TWO_PI);
    vertex(r * cos(theta), r * sin(theta));

    for (int bumps = 0; bumps < maxlen && r > 0; bumps++) {
      final float dt = random(maxdt);
      r -= random(R * maxdr);
      theta += dt;
      if (r > 0) {
        vertex(r * cos(theta), r * sin(theta));
      }
    }

    endShape();
  }
}

void circle(float X, float Y, float R) {
  pushMatrix();
  translate(X, Y);

  final int maxlen = int(random(5, 25));
  final float maxdt = random(TWO_PI / 10) * (random(1) > 0.5 ? 1.0 : -1.0);
  final float maxdr = random(0.5, 1.5) / float(maxlen);
  spiral(R, maxlen, maxdt, maxdr);

  popMatrix();
}
