/*
 * Connecting points of phyllotaxis using Bezier curves.
 * Can look like a whirlpool or a sunflower.
 *
 * Unfortunately, most of the output dependence comes from the choice of
 * "skip", which is necessarily a small integer.
 */
void phyllotaxis(float X, float Y, float R, float density, int skip) {
  final float	phi	= (sqrt(5) + 1) / 2;
  final float	alpha	= (2 * PI) / (phi * phi);
  final float	offset	= random(2 * PI);
  final int	np	= int(density * density);
  float		p;

  pushMatrix();
  translate(X, Y);
  for (int n = 0; n < np - skip * 3; n++) {
    p			= float(n + skip * 0);
    final float	x0	= sqrt(p) * (R / density) * cos(p * alpha + offset);
    final float	y0	= sqrt(p) * (R / density) * sin(p * alpha + offset);
    p			= float(n + skip * 1);
    final float	x1	= sqrt(p) * (R / density) * cos(p * alpha + offset);
    final float	y1	= sqrt(p) * (R / density) * sin(p * alpha + offset);
    p			= float(n + skip * 2);
    final float	x2	= sqrt(p) * (R / density) * cos(p * alpha + offset);
    final float	y2	= sqrt(p) * (R / density) * sin(p * alpha + offset);
    p			= float(n + skip * 3);
    final float	x3	= sqrt(p) * (R / density) * cos(p * alpha + offset);
    final float	y3	= sqrt(p) * (R / density) * sin(p * alpha + offset);

    bezier(x0, y0, x1, y1, x2, y2, x3, y3);
  }
  popMatrix();
}

void circle(float X, float Y, float R) {
  noFill();
  stroke(255, 16);

  int skip = int(random(1, 9));
  for (int i = 0; i < 128; i++) {
    phyllotaxis(X, Y, R, random(3, 10), skip);
  }
}
