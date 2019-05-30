/*
 * Random walk from the middle to the border.
 * A step can be taken as long as it gets me closer to the border.
 */
void circle(float X, float Y, float R) {
  pushMatrix();
  translate(X, Y);
  noFill();

  for (int i = 0; i < 100; i++) {
    float ox, oy, nx, ny;
    float theta;

    beginShape();
    vertex(0, 0);
    ox = oy = 0;
    do {
      stroke(random(255));
      do {
	theta = random(2 * PI);
	nx = ox + cos(theta);
	ny = oy + sin(theta);
      } while (nx * nx + ny * ny < ox * ox + oy * oy);
      vertex(nx, ny);
      ox = nx;
      oy = ny;
    } while (nx * nx + ny * ny < R * R);
    endShape();
  }

  popMatrix();
}
