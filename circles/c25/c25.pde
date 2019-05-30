/*
 * Wobbly ellipses.
 */
void circle(float X, float Y, float R) {
  float w, h, tw, th;
  final float minchange = random(0.7, 0.95);
  final float shrink = random(minchange, 1 - (1 - minchange) / 3);

  noFill();
  stroke(192, 192);
  pushMatrix();
  translate(X, Y);
  rotate(random(TWO_PI));

  w = tw = h = th = 2 * R;
  while (w + h > R / 10) {
    if (w > tw) {
      w *= shrink;
    } else if (h > th) {
      h *= shrink;
    } else {
      if (random(1) > 0.5) {
        tw = random(w * minchange, w);
      } else {
        th = random(h * minchange, h);
      }
    }
    ellipse(0, 0, w, h);
  }
  popMatrix();
}
