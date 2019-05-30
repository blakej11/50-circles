/*
 * Recursive phyllotaxis: attempt to simulate a Romanesco cauliflower.
 */
void phyllotaxis(float X, float Y, float R, float spacing) {
  final float	phi = (sqrt(5) + 1) / 2;
  final float	alpha = (2 * PI) / (phi * phi);		// the "Golden Angle"
  pushMatrix();
  translate(X, Y);

  /*
   * Standard phyllotaxis uses dist = K * sqrt(n). That was packed so tightly
   * that it was hard to see any next layers, so I used a different power of n.
   * The corresponding radius of the new circle seemed like it should also be
   * proportional to n, R, and spacing; these values are empirically chosen
   * (rather than being given by some clever derivation).
   */
  for (float n = 0; ; n++) {
    final float	dist = pow(n, 0.7) * R * spacing;	// distance from center
    final float	r = pow(n, 0.25) * R * spacing;		// radius of new circle
    final float	x = dist * cos(n * alpha);
    final float	y = dist * sin(n * alpha);

    if (dist + r >= R) {
      break;
    } else if (r <= 4) {
      for (int i = 1; i <= 4; i++) {
      	final float d = (r * 2) * float(5 - i) / 4;
       	stroke(color(0, min(i * 64, 255), 0));
        ellipse(x, y, d, d);
      }
    } else {
      phyllotaxis(x, y, r, spacing);
    }
  }

  popMatrix();
}

// A spacing value of 0.033 looks pretty nice.
void circle(float X, float Y, float R) {
  final float	spacing = random(0.015, 0.100);
  noFill();
  stroke(color(0, 255, 0));
  ellipse(X, Y, 2 * R, 2 * R);
  phyllotaxis(X, Y, R, spacing);
}
