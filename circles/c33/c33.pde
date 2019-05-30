/*
 * Arcs between concentric circles.
 *
 * P2D and JAVA2D show different moire-like patterns at different scales.
 * Going with JAVA2D, just 'cause.
 */
void circle(float X, float Y, float R) {
  final float minR = R * 0.01;
  
  pushMatrix();
  translate(X, Y);
  noFill();
  stroke(255, 64);
  ellipse(0, 0, 2 * R, 2 * R);

  while (R > minR) {
    final int narcs = int(random(10, 100)); // number of arcs
    final float shrink = random(0.05, 0.80); // shrink factor
    final float r = R * shrink;

    // How long the arc should go so it stops at the outer radius.
    // This formula brought to you by the law of cosines.
    final float arclen = PI - acos((5 * shrink - 4) / (8 - 4 * shrink));

    for (int i = 0; i < narcs; i++) {
      final float d = 2 * R - r;
      float theta = (float(i) / float(narcs) * TWO_PI);

      rotate(theta);
      arc(r, 0, d, d, arclen, TWO_PI - arclen);
      rotate(-theta);
    }

    /*
     * Draw the inner circumcircle.
     * When shrink > 2/3, the inner circle is tangent to the inside of the arc;
     * when shrink = 2/3, the inner circle disappears;
     * when shrink < 2/3, the inner circle is tangent to the outside.
     */
    final float nr = abs(1.5 * shrink - 1) * R;
    ellipse(0, 0, nr * 2, nr * 2);
    R = nr;
  }

  popMatrix();
}
