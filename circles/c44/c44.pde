/*
 * Warped tree rings, using Perlin noise.
 */

/*
 * This avoids using X and Y as part of the noise input, so a given circle
 * only depends on the random seed (rather than also depending on its
 * placement).
 */
void ring(float r, float rmag, float nscale, float z) {
  beginShape();
  final float s = random(r);
  for (float i = s; i < s + r + 3; i++) {
    final float theta = i * TWO_PI / r;
    final float ct = cos(theta);
    final float st = sin(theta);
    final float n = noise(ct * nscale, st * nscale, (z / r) * nscale);
    final float x = r * ct;
    final float y = r * st;
    curveVertex(x + rmag * cos(TWO_PI * n), y + rmag * sin(TWO_PI * n));
  }
  endShape();
}

void circle(float X, float Y, float R) {
  final float nmag = random(4, 10);	// larger = bigger noise effect
  final float nedge = random(0.2, 0.6);	// larger = wilder at edges
  final float nscale = random(1, 5);	// larger = finer grained noise
  final float z = random(-R, R);	// closer to 0 = less radial symmetry
  final boolean banding = true;

  pushMatrix();
  translate(X, Y);
  stroke(255, 64);
  noFill();

  for (int c = 1; c < int(R); c++) {
    final float r = (banding ? random(R) : float(c));

    // Scale of noise factor to use for this ring.
    final float rmag = nmag * pow((r / R) + nedge, 1.2 + nedge * 2);

    ring(r, rmag, nscale, z);
  }

  popMatrix();  
}
