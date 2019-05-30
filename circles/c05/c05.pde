/*
 * Waves, with opacity equal to darkness.
 *
 * Using P2D leads to more uniform gradients.
 */
void circle(float X, float Y, float R) {
  float div = random(10);
  pushMatrix();
  translate(X, Y);
  rotate(random(2 * PI));
  noFill();

  for (float x = -R; x < R; x += 0.5) {
    float y = sqrt(R * R - x * x);
    float col = (sin(x / div) + 1.0) * 127.5;
    stroke(col, 255 - col);
    line(x, -y, x, y);
  }

  popMatrix();
}
