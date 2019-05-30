/*
 * Eyes (irises), via additive jagged circles.
 */

/*
 * R        = radius, in pixels
 * E        = eccentricity
 * depth    = recursion depth
 * maxdepth = recursion depth limit
 * parents  = jump data, from parent invocation
 */
void layer(float R, float E, int depth, int maxdepth,
    ArrayList<Float> parents) {
  final int nvertex = 1 << maxdepth;
  final int chunk = 1 << (maxdepth - depth);

  if (depth < maxdepth) {
    /*
     * If we're below the max depth, we add in "jumps" of varying amounts.
     * Lower values of "depth" span more vertices and have larger jumps,
     * while higher values are the opposite. These jumps are added starting
     * at random offsets within the vertex array, so they don't all get
     * in phase with each other.
     */
    ArrayList<Float> curdepth = new ArrayList<Float>();
    for (int v = 0; v < nvertex; v++) {
      curdepth.add(0.0);
    }

    for (int i = 0; i < 3; i++) {
      final int offset = int(random(float(nvertex)));

      for (int v = 0; v < nvertex; v += chunk) {
        final float shrink = pow(2.0, -depth);
        final float nv = parents.get(v) + random(-shrink, shrink);
        for (int l = 0; l < chunk; l++) {
          curdepth.set((v + l + offset) % nvertex, nv);
        }
      }
      layer(R, E, depth + 1, maxdepth, curdepth);
    }

  } else {
    float js[] = new float[3];

    /*
     * Once we've reached max depth, we draw the shape.
     *
     * If the first and last three points of the curve aren't the same,
     * it will have some jagged corners or straight lines. So we save the
     * first three points in js[] and reuse them as the last three points.
     */
    for (int i = 0; i < 3; i++) {
      beginShape();
      for (int v = 0; v < nvertex + 3; v++) {
        final int nv = v % nvertex;
        float jump = 0.0;

        if (v < nvertex) {
          final float shrink = pow(2.0, -depth);
          jump = random(-shrink, shrink);
        }

        if (nv < 3) {
          if (v < nvertex) {
            js[nv] = jump;
          } else {
            jump = js[nv];
          }
        }

        final float theta = TWO_PI * float(nv) / float(nvertex);
        final float cost = cos(theta);
        final float sint = sin(theta);
        final float eccfactor = sqrt(cost * cost + E * sint * sint);
        final float jumpfactor = (1.0 + parents.get(nv) + jump) / 1.5;
        final float r = R * eccfactor * jumpfactor;
        curveVertex(r * cost, r * sint);
      }
      endShape();
    }
  }
}

void circle(float X, float Y, float R) {
  // this amount seems good in practice
  final int maxdepth = int((log(R) / log(3)) + 2);

  // roughly matches the shape of an eye
  final float eccentricity = 0.7;

  pushMatrix();
  translate(X, Y);
  noFill();
  stroke(255, 8);

  // Start the recursion with an empty array.
  ArrayList<Float> root = new ArrayList<Float>();
  for (int v = 0; v < 1 << maxdepth; v++) {
    root.add(0.0);
  }
  layer(R, eccentricity, 1, maxdepth, root);

  popMatrix();
}
