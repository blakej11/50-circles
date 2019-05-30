/*
 * Basic phyllotaxis.
 */
void phyllotaxis(float X, float Y, float R, float density) {
  final float	phi	= (sqrt(5) + 1) / 2;
  final float	alpha	= (2 * PI) / (phi * phi);

  pushMatrix();
  translate(X, Y);
  for (float n = 1; n < density * density; n++) {
    final float	dist	= sqrt(n) * (R / density);
    final float	x	= dist * cos(n * alpha);
    final float	y	= dist * sin(n * alpha);
    final float	r	= (phi / 2) * (R / density);

    ellipse(x, y, r * 2, r * 2);
  }
  popMatrix();
}

void circle(float X, float Y, float R) {
  final float	density	= random(10, 80);

  noFill();
  phyllotaxis(X, Y, R, density);
}
