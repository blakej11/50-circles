/*
 * More complex spiderweb.
 */

public class Pair<A, B> {
    private final A first;
    private final B second;

    public Pair(A first, B second) {
        super();
        this.first = first;
        this.second = second;
    }

    public A getFirst() {
        return first;
    }

    public B getSecond() {
        return second;
    }
}

// Might be interesting to try to get a curve to intersect these two points...
// but not bothering for now.
void spiralthread(Pair<Float, Float> angles, float r1, float r2) {
  final float t1 = angles.getFirst();
  final float t2 = angles.getSecond();  
  line(r1 * cos(t1), r1 * sin(t1), r2 * cos(t2), r2 * sin(t2));
}

void circle(float X, float Y, float R) {
  final float Rbp = R * 0.0001; // one basis point of radius
  final int spokes = int(random(7, 15) * (R / 100));
  final float baseangle = TWO_PI / float(spokes);
  ArrayList<Pair<Float, Float>> angles = new ArrayList<Pair<Float, Float>>();

  // Calculate the angles for the spokes.
  float oa = 0;
  for (int i = 1; i < spokes; i++) {
    final float a = float(i) * baseangle;
    final float na = random(a - baseangle / 4, a + baseangle / 4);

    angles.add(new Pair(oa, na));
    oa = na;
  }
  angles.add(new Pair(oa, TWO_PI));

  pushMatrix();
  translate(X, Y);
  rotate(random(TWO_PI));

  // Draw the radius threads.
  stroke(128, 128);
  for (Pair<Float, Float> a : angles) {
    final float theta = a.getSecond();
    line(0, 0, R * cos(theta), R * sin(theta));
  }

  // Draw the spiral threads.
  stroke(192, 128);
  float r, or, nr;
  r = or = nr = R / 20;
  while (r < R) {
    for (Pair<Float, Float> a : angles) {
      // This formula for "r" is arbitrary, but it seems to look nice.
      r *= (1 + 2 * baseangle / R);
      nr = r * (1 + random(-5, 5) / R);
      if (nr < R) {
        spiralthread(a, or, nr);
      }
      or = nr;
    }
  }

  // Draw the outside threads.
  for (Pair<Float, Float> a : angles) {
    spiralthread(a, R, R);
  }

  popMatrix();
}
