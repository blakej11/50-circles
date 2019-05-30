/*
 * Random walk from the middle to the border.  The closer it gets to the
 * border, the shorter the steps can be, and the lighter the line gets.
 */
void circle(float X, float Y, float R) {
  pushMatrix();
  translate(X, Y);
  noFill();

  for (int i = 0; i < 100; i++) {
    float ox, oy, d;

    ox = oy = d = 0;
    do {
      float len = random(R - d) + 1;
      float theta = random(2 * PI);
      float nx = ox + len * cos(theta);
      float ny = oy + len * sin(theta);

      stroke(255 * random(d / R));
      line(ox, oy, nx, ny);
      ox = nx;
      oy = ny;
      d = sqrt(nx * nx + ny * ny);
    } while (d < R);
  }

  popMatrix();
}
