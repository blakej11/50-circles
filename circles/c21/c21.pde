/*
 * Defining a circle by tangent lines.
 */
void circle(float X, float Y, float R) {
  final int nthreads = int(random(R / 4, R * 2));

  pushMatrix();
  translate(X, Y);
  stroke(map(nthreads, R / 4, R * 2, 255, 64), 128);

  for (int i = 0; i < nthreads; i++) {
    final float theta = random(TWO_PI);
    final float St = sin(theta);
    final float Ct = cos(theta);
    float       x1, y1, x2, y2;

    /*
     * tangent line: y = -cot(theta) * x + b
     * intersects with: x = R * cos(theta), y = R * sin(theta)
     * R sin theta = -cot theta * R cos theta + b
     * b = R sin theta + cot theta * R cos theta
     *   = R (sin theta + cos^2 theta / sin theta)
     *   = R (sin^2 theta + cos^2 theta) / sin(theta)
     *   = R / sin(theta)
     * 
     * -> y = -cot(theta) * x + R / sin(theta)
     *    x cos theta + y sin theta = R
     * 
     * intersects with:
     * - X =  R, Y =  t; t in { -R, R }
     * - X = -R, Y =  t; t in { -R, R }
     * - X =  t, Y =  R; t in { -R, R }
     * - X =  t, Y = -R; t in { -R, R }
     */
    if (-1 <= (1 - Ct) / St && (1 - Ct) / St <= 1) {
      x1 = 1;
      y1 = (1 - Ct) / St;
    } else {
      x1 = -1;
      y1 = (1 + Ct) / St;
    }

    if (-1 <= (1 - St) / Ct && (1 - St) / Ct <= 1) {
      x2 = (1 - St) / Ct;
      y2 = 1;
    } else {
      x2 = (1 + St) / Ct;
      y2 = -1;
    }

    line(R * x1, R * y1, R * x2, R * y2);
  }

  popMatrix();
}
