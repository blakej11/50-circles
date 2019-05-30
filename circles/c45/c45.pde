/*
 * Warped tree rings plus a knot.
 *
 * P2D gives higher intensity noise-based distortion.
 */

/*
 * Draw one vertex in a knot.
 *
 * ring() gave us a space that looks like an eye, with the upper and lower
 * bounds being cosine curves stretched by some factor.  This moves from that
 * shape into an ellipse/circle, and then shrinks the circle down to a point.
 *
 * theta	= current angle within the knot (within [-dtheta, dtheta])
 * dtheta	= bounds for theta
 * sign		= 1.0 for outside of knot, -1.0 for inside of knot
 * rmag		= how much weight to give the noise
 * nscale	= how far out in (x, y) Perlin noise space to get noise from
 * z		= how far out in (z) Perlin noise space to get noise from
 * blend	= at 1, make it a pair of cosines; at 0, make it circular
 * r		= radius of this ring of the knot
 * knotR	= distance from center of tree to center of knot
 * knotT	= angle from center of tree to center of knot
 */
void knotpoint(float theta, float dtheta, float sign,
    float rmag, float nscale, float z,
    float blend, float r, float knotR, float knotT) {

  // Outline the knot.
  final float ct = cos(knotT + theta);
  final float st = sin(knotT + theta);
  final float cosdr = cos(theta / dtheta * HALF_PI);
  final float circledr = sqrt(1 - sq(theta / dtheta));
  final float dr = r * sign * (blend * cosdr + (1 - blend) * circledr);

  // Add noise.
  final float n = noise(ct * nscale, st * nscale, (z / knotR) * nscale);
  final float cn = cos(TWO_PI * n);
  final float sn = sin(TWO_PI * n);

  curveVertex((knotR + dr) * ct + rmag * cn, (knotR + dr) * st + rmag * sn);
}

/*
 * Draw one ring in a knot, by walking its top and bottom.
 *
 * This is less than perfect, because it uses sqrt(1 - x^2) (via knotpoint())
 * to get the circle shape, while walking x linearly. In practice this means
 * that the points near the "Y axis" (i.e. the curve of the ring ellipse,
 * as opposed to the knot ellipse) are spread out more sparsely, which appears
 * to create an unwanted visual banding effect.
 *
 * An ideal solution would be to walk uniformly across the theta's used for
 * this ellipsoid shape. But it's not actually an ellipse, and trying to
 * figure out how to create it just from its own center seems challenging.
 */
void knot(float rmag, float nscale, float z, 
    float blend, float dtheta, float r, float knotR, float knotT) {
  final float stheta = random(-dtheta, dtheta - 0.03);

  beginShape();

  knotpoint(stheta,  dtheta,  1.0, rmag, nscale, z, blend, r, knotR, knotT);
  for (float theta = stheta; theta < dtheta; theta += 0.01) {
    knotpoint(theta, dtheta,  1.0, rmag, nscale, z, blend, r, knotR, knotT);
  }
  for (float theta = dtheta; theta > -dtheta; theta -= 0.01) {
    knotpoint(theta, dtheta, -1.0, rmag, nscale, z, blend, r, knotR, knotT);
  }
  for (float theta = -dtheta; theta < stheta; theta += 0.01) {
    knotpoint(theta, dtheta,  1.0, rmag, nscale, z, blend, r, knotR, knotT);
  }
  knotpoint(stheta,  dtheta,  1.0, rmag, nscale, z, blend, r, knotR, knotT);

  endShape(CLOSE);
}

/*
 * Draw one ring of the tree.
 *
 * r		= radius of this ring of the tree
 * rmag		= how much weight to give the noise
 * nscale	= how far out in (x, y) Perlin noise space to get noise from
 * z		= how far out in (z) Perlin noise space to get noise from
 * ecc		= eccentricity of the knot hole
 * knotr	= radius of the knot
 * knotR	= distance from center of tree to center of knot
 * knotT	= angle from center of tree to center of knot
 */
void ring(float r, float rmag, float nscale, float z,
    float ecc, float knotr, float knotR, float knotT) {
  final float kdr = abs(r - knotR);

  beginShape();
  final float s = random(r);
  for (float i = s; i < s + r + 3; i++) {
    final float theta = (i * TWO_PI / r) % TWO_PI;
    final float ct = cos(theta);
    final float st = sin(theta);

    // Add space for a knot, if desired.
    float dr = 0;
    if (kdr < 2 * knotr) {
      final float kdy = knotr - kdr / 2;
      final float dtheta = atan2(kdr + ecc * knotr, knotR + kdy);
      final float dt = (abs(theta - knotT) + dtheta) % TWO_PI - dtheta;
      if (dt <= dtheta) {
        dr = kdy * cos(dt / dtheta * HALF_PI) * (r < knotR ? -1.0 : 1.0);
      }
    }

    // Add noise.
    final float n = noise(ct * nscale, st * nscale, (z / r) * nscale);
    final float cn = cos(TWO_PI * n);
    final float sn = sin(TWO_PI * n);

    curveVertex((r + dr) * ct + rmag * cn, (r + dr) * st + rmag * sn);
  }
  endShape();
}

void circle(float X, float Y, float R) {
  final float nmag = random(2, 5);	// larger = bigger noise effect
  final float nedge = random(0.2, 0.6);	// larger = wilder at edges
  final float nscale = random(1, 5);	// larger = finer grained noise
  final float z = random(-R, R);	// closer to 0 = less radial symmetry
  final float ringweight = 8;		// smaller = finer rings in center
  final float ecc = random(1.5, 3.0);	// knot hole eccentricity
  final float knotr = random(R * 0.05, R * 0.15);	// knot radius
  final float knotR = random(R * 0.25, R * 0.85);	// knot center's radius
  final float knotT = random(TWO_PI);			// knot center's theta

  boolean light;	// currently drawing a light ring?
  boolean knotlight;	// should the knot start with a light ring?
  float thickness;	// current ring thickness

  pushMatrix();
  translate(X, Y);
  noFill();

  // Draw the main tree rings.
  strokeWeight(1.5);
  knotlight = light = true;
  for (float r = 1; r < R; ) {

    // Thickness of this ring.
    thickness = (light ? (1 + random(3)) : (0.5 + sq(random(1.5))));
    thickness *= (ringweight - 1 + r / R) / ringweight;

    final float sr = r;
    for (; r < sr + thickness; r += 0.25) {

      // Color of this ring.
      final float dcolor = abs(((r - sr) / thickness - 0.5) * 192);
      stroke((light ? (224 - dcolor) : (32 + dcolor)), 16);
      if (r > knotR && r - 0.25 < knotR) {
	knotlight = light;
      }

      // How wiggly this ring should be.
      final float ringloc = (r / R);
      final float rmag = nmag * pow(ringloc + nedge, 1.2 + nedge * 2);

      // Draw the ring.
      ring(r, rmag, nscale, z, ecc, knotr, knotR, knotT);
    }

    light = !light;
  }

  /*
   * Draw the knot, one ring at a time.
   * Here the thing that's varying is the *vertical* radius of the knot.
   */
  strokeWeight(0.5);
  light = knotlight;
  for (float r = knotr; r >= 0; ) {

    // Thickness of this ring.
    thickness = (light ? (0.5 + random(1)) : (0.25 + sq(random(1))));
    thickness *= (ringweight - 1 + r / knotr) / ringweight;

    final float sr = r;
    for (; r > sr - thickness && r > 0; r -= 0.05) {

      // Color of this ring.
      final float dcolor = abs(((sr - r) / thickness - 0.5) * 192);
      stroke((light ? (224 - dcolor) : (32 + dcolor)), 16);

      // How wiggly this ring should be.
      final float ringloc = (knotR / R) * (r / knotr);
      final float rmag = nmag * pow(ringloc + nedge, 1.2 + nedge * 2);

      // How wide this ring should be.
      final float recc = max((r / knotr) * ecc, 1.0);
      final float blend = (recc - 1.0) / (ecc - 1.0);
      final float dtheta = atan2(r * recc, r + knotR);

      // Draw the ring.
      knot(rmag, nscale, z, blend, dtheta, r, knotR, knotT);
    }

    light = !light;
  }

  popMatrix();  
}
