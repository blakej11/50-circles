/*
 * Time-elapsed pattern of a sparkler being waved around inside a circle.
 */

public class Point {
    private final float x;
    private final float y;

    public Point(float x, float y) {
        super();
        this.x = x;
        this.y = y;
    }

    public float getX() {
        return x;
    }

    public float getY() {
        return y;
    }
}

/* Chaikin curve subdivision, with random wiggles. */
ArrayList<Point> subdivide(ArrayList<Point> points, float wiggle) {
  ArrayList<Point> npoints = new ArrayList<Point>();
  Point op = null;

  for (Point np : points) {
    if (op != null) {
      npoints.add(new Point(
          (op.getX() * 3 + np.getX() * 1) / 4 + random(-wiggle, wiggle),
          (op.getY() * 3 + np.getY() * 1) / 4 + random(-wiggle, wiggle)));
      npoints.add(new Point(
          (op.getX() * 1 + np.getX() * 3) / 4 + random(-wiggle, wiggle),
          (op.getY() * 1 + np.getY() * 3) / 4 + random(-wiggle, wiggle)));
    }
    op = np;
  }

  return (npoints);
}

void recurse(int depth, int maxdepth, ArrayList<Point> points) {
  if (depth >= maxdepth / 2) {
    // The further in we go, the less opaque the line...
    stroke(255, 64 >> (depth - maxdepth / 2));

    beginShape();
    for (Point p : points) {
      vertex(p.getX(), p.getY());
    }
    endShape();
  }

  if (depth < maxdepth) {
    // ... but the wilder the line gets.
    final float wiggle = float(1 << depth);

    recurse(depth + 1, maxdepth, subdivide(points, wiggle));
    recurse(depth + 1, maxdepth, subdivide(points, wiggle));
  }
}

void circle(float X, float Y, float R) {
  final int maxdepth = int((log(R) / log(3)) + 1); // seems nice
  ArrayList<Point> points = new ArrayList<Point>();

  for (int i = 0; i < 100; i++) {
    float t1 = random(TWO_PI);
    points.add(new Point(R * cos(t1), R * sin(t1)));
  }

  noFill();
  pushMatrix();
  translate(X, Y);
  recurse(0, maxdepth, points);
  popMatrix();
}
