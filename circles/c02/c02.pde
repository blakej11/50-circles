/*
 * The circle is the limit of regular N-sided polygons.
 * Draw some of them.
 */
void circle(float x, float y, float r) {
  final float rotation = random(2 * PI);

  for (int vertices = 3; vertices < 256; vertices++) {
    float	ox, oy;

    if (random(1) < 0.5) {
      continue;
    }
    
    ox = x + r * cos(rotation);
    oy = y + r * sin(rotation);

    for (int vertex = 0; vertex <= vertices; vertex++) {
      final float	theta	= (float)vertex * 2 * PI / (float)vertices;
      final float	nx	= x + r * cos(theta + rotation);
      final float	ny	= y + r * sin(theta + rotation);
      line(ox, oy, nx, ny);
      ox = nx;
      oy = ny;
    }
  }
}
