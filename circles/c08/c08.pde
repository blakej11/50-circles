/*
 * Repeat the following:
 * - pick a line within the circle, and a point on it
 * - intersect that line segment with the circle, stopping at R
 * - intersect it with each existing line segment too
 * - draw the resulting segment
 * - draw up to R^2 total length
 */

class Line {
  float	_m;	// slope
  float	_b;	// intercept
  float	_x0;	// definite point to keep
  float	_xmin;	// minimum X value
  float	_xmax;	// maximum X value

  Line(float r) {
    final float		r0 = sqrt(random(r * r));
    final float		t0 = random(2 * PI);
    final float		x0 = r0 * cos(t0);
    final float		y0 = r0 * sin(t0);

    final float		r1 = sqrt(random(r * r));
    final float		t1 = random(2 * PI);
    final float		x1 = r1 * cos(t1);
    final float		y1 = r1 * sin(t1);

    _m = (y1 - y0) / (x1 - x0);
    _b = (y0 * x1 - x0 * y1) / (x1 - x0);
    _x0 = x0;

    /*
     * This gives the solutions (xmin and xmax) to:
     *   x^2 + y^2 = r^2
     *   y = m * x + b
     */
    final float		xmsqrt =
        sqrt(r * r * (_m * _m + 1) - _b * _b) / (_m * _m + 1);
    final float		xmminb = -_m * _b / (_m * _m + 1);

    _xmin = xmminb - xmsqrt;
    _xmax = xmminb + xmsqrt;
  }

  /*
   * Trim out any part of the current Line that hits the existing Line <l>.
   *
   * This line:		y = m0 * x + b0
   * Existing line <l>:	y = m1 * x + b1
   * They intersect at: x = (b1 - b0) / (m0 - m1)
   */
  void intersect(Line l) {
    final float			X = (l._b - _b) / (_m - l._m);
    if (X < l._xmin || l._xmax < X || X < _xmin || _xmax < X) {
      return;
    }

    if (X < _x0) {
      _xmin = X;
    } else {
      _xmax = X;
    }
  }

  float length() {
    final float		x = _xmax - _xmin;
    final float		y = _m * x;
    return (sqrt(x * x + y * y));
  }

  void draw() {
    final float		ymin = _m * _xmin + _b;
    final float		ymax = _m * _xmax + _b;
    line(_xmin, ymin, _xmax, ymax);
  }

} /* end of class Line */

void circle(float X, float Y, float R) {
  ArrayList<Line>	lines = new ArrayList<Line>();
  float			length;

  pushMatrix();
  translate(X, Y);

  length = 0;
  do {
    Line l = new Line(R);
    for (Line o : lines) {
      l.intersect(o);
    }
    l.draw();
    lines.add(l);
    length += l.length();
  } while (length < R * R);

  noFill();
  ellipse(0, 0, 2 * R, 2 * R);
  popMatrix();
}
