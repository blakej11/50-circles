/*
 * Furry stars, via additive jagged circles.
 */
void circle(float X, float Y, float R) {
  final float jangle = 88; // random(5, 35);

  pushMatrix();
  translate(X, Y);
  fill(255, 4);
  noStroke();

  final int maxJ = 128; // int(R);
  final int maxdepth = int(log(maxJ) / log(2.0));

  for (float i = 0; i < 128; i++) {
    ArrayList<Float> verts = new ArrayList<Float>();
    ArrayList<Float> depths = new ArrayList<Float>();

    rotate(random(TWO_PI));
    beginShape();

    for (int d = 0; d < maxdepth; d++) {
      depths.add(random(-1 / float(1 << d), 1 / float(1 << d)));
    }

    for (int j = 0; j < maxJ; j++) {
      float cr = 1.0;
      for (int d = 0; d < maxdepth; d++) {
        if (j / (1 << d) != (j - 1) / (1 << d)) {
          depths.set(d, random(-1 / float(1 << d), 1 / float(1 << d)));
        }
        cr += depths.get(d) / 2.0;
      }
      cr *= R;

      final float theta = TWO_PI * float(j) / float(maxJ);
      curveVertex(cr * cos(theta), cr * sin(theta));

      if (j < 3) {
        verts.add(cr);
      }
    }

    for (int j = 0; j < 3; j++) {
      final float cr = verts.get(j);
      final float theta = TWO_PI * float(j) / float(maxJ);
      curveVertex(cr * cos(theta), cr * sin(theta));
    }
    endShape();
  }

  popMatrix();
}
