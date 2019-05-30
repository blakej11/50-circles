/*
 * Whirlpools.
 */
void circle(float X, float Y, float R) {
  final float dr = random(0.5) * (random(1) < 0.5 ? 1 : -1);
  final color c1 = color(random(255));
  final color c2 = color(random(255));

  pushMatrix();
  translate(X, Y);
  rotate(random(2 * PI));
  
  for (float r = R; r > 1; r *= 0.97) {
    rotate(dr);
    for (float x = -r; x < r; x += 0.25) {
      final float y = sqrt(r * r - x * x);
      final float interp = map(x, -r, r, 0, 1);
      stroke(lerpColor(c1, c2, interp));
      line(x, -y, x, y);
    }
  }

  popMatrix();
}
