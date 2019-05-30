/*
 * Random-width stripes within the circle.
 *
 * P2D and JAVA2D show different moire patterns at different scales.
 * Going with P2D, just 'cause.
 */
void circle(float X, float Y, float R) {
  final float	dist = random(0.5, 10);
  
  pushMatrix();
  translate(X, Y);
  rotate(random(2 * PI));

  for (float x = -R; x < R; x += dist) {
    float y = sqrt(R * R - x * x);
    line(x, -y, x, y);
  }

  popMatrix();
}
