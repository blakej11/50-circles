/*
 * Mountains, via additive jagged circles.
 * See the similar "c37" for some comments about how it works.
 */

void layer(float R, int depth, int maxdepth, ArrayList<Float> parents) {
  ArrayList<Float> curdepth = new ArrayList<Float>();

  for (int i = 0; i < 3; i++) {
    for (int v = 0; v < 1 << maxdepth; v++) {
      final float shrink = pow(2.0, -depth);
      final float nv = parents.get(v) + random(-shrink, shrink);

      if (i == 0) {
        curdepth.add(nv);
      } else {
        curdepth.set(v, nv);
      }
    }

    if (depth < maxdepth) {
      layer(R, depth + 1, maxdepth, curdepth);
    } else {
      beginShape();
      for (int v = 0; v < 1 << maxdepth + 3; v++) {
        final int nv = v % (1 << maxdepth);
        final float cr = R * (1.0 + curdepth.get(nv)) / 1.5;
        final float theta = TWO_PI * float(nv) / float(1 << maxdepth);
        curveVertex(cr * cos(theta), cr * sin(theta));
      }
      endShape();
    }
  }
}

void circle(float X, float Y, float R) {
  final int maxdepth = 5;
  
  pushMatrix();
  translate(X, Y);
  fill(255, 2);
  noStroke();

  ArrayList<Float> root = new ArrayList<Float>();
  for (int v = 0; v < 1 << maxdepth; v++) {
    root.add(0.0);
  }
  layer(R, 1, maxdepth, root);

  popMatrix();
}
