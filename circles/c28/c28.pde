/*
 * Topo maps of mountains.
 */
void circle(float X, float Y, float R) {
  final int rings = int(random(R / 20, R / 8));
  final float dampen = random(0.999, 0.9999);	// closer to 1 = less dampening

  ArrayList<Float> ovs, nvs;
  int onv;
  float jangle;

  pushMatrix();
  translate(X, Y);
  strokeJoin(ROUND);
  noStroke();
  fill(255, 512 / rings);

  jangle = random(R / 4, R / 1.5) / rings; // how much noise to add

  ovs = new ArrayList<Float>();
  onv = 0;
  for (int ring = 0; ring < rings; ring++) {
    final float r = float(ring) * R / float(rings);
    final int nv = int(r);		// # vertices = radius
    final float dr = random(TWO_PI);

    if (nv < 10) {
      continue;
    }

    nvs = new ArrayList<Float>();
    rotate(dr);
    strokeWeight(2.0);
    beginShape();

    for (int v = 0; v < nv; v++) {
      final float theta = TWO_PI * float(v) / float(nv);
      float noise;

      if (onv != 0) {
        // Do a linear interpolation from the previous circle's noise.
        final float oang = (theta + dr) % TWO_PI;
        final float ovtx = (oang / TWO_PI) * float(onv);
        final float lower = ovs.get(floor(ovtx)) * (1 - (ovtx % 1.0));
        final float higher = ovs.get(ceil(ovtx) % onv) * (ovtx % 1.0);
        noise = ((lower + higher - 1) * dampen) + 1;
      } else {
        noise = 1;	// just start with a circle
      }

      // Add this circle's noise, on top of whatever came before it.
      noise *= random(1 - jangle/r, 1 + jangle/r);
      jangle *= dampen;
      
      nvs.add(noise);
      curveVertex(noise * r * cos(theta), noise * r * sin(theta));
    }

    endShape(CLOSE);
    ovs = nvs;
    onv = nv;
  }

  popMatrix();
}
