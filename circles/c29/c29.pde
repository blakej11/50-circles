/*
 * Partial translucent cymbals.
 */
 
void gradient_arc(float r, float stheta, float etheta, color sc, color ec) {
  final float dt = (etheta - stheta) / r;
  noStroke();
  // If this increments by "dt" rather than "dt/2", it leaves unfortunate
  // gaps between the wedges.
  for (float t = stheta; t < etheta; t += dt / 2) {
    final float grey = map(t, stheta, etheta, sc, ec);
    fill(color(grey), grey);
    arc(0, 0, 2 * r, 2 * r, t, t + dt, PIE);
  }
}

void circle(float X, float Y, float R) {
  final float a = random(PI);
  final float b = random(a, PI * 1.5);
  final float c = random(b, TWO_PI);

  pushMatrix();
  translate(X, Y);
  rotate(random(TWO_PI));
  gradient_arc(R, a, b, 0, 255);
  gradient_arc(R, b, c, 255, 0);
  popMatrix();
}
