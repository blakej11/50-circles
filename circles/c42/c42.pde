/*
 * Voronoi diagram, radiating from a central point.
 */

// http://leebyron.com/mesh/
import megamu.mesh.*;

class VPhyllo implements Drawcircle {
  float _density, _linedark;
  boolean _inverted, _opaque;

  VPhyllo(float density, float linedark, boolean inverted, boolean opaque) {
    _density = density;
    _linedark = linedark;
    _inverted = inverted;
    _opaque = opaque;
  }

  void draw(PGraphics canvas, float R) {
    final int npoints = int(_density);
    final float cr = random(R * 3 / 4);
    final float ct = random(TWO_PI);
    final float cx = R + cr * cos(ct);
    final float cy = R + cr * sin(ct);

    float[][] points = new float[npoints][2];
    for (int n = 1; n < npoints; n++) {
      final float pr = randomGaussian() * R / 2;
      final float pt = randomGaussian() * TWO_PI;
      points[n][0] = cx + pr * cos(pt);
      points[n][1] = cy + pr * sin(pt);
    }
    Voronoi v = new Voronoi(points);

    canvas.strokeWeight(_linedark);
    MPolygon[] regions = v.getRegions();
    for (int i = 0; i < regions.length; i++) {
      final float dx = points[i][0] - cx;
      final float dy = points[i][1] - cy;
      final float rx = sqrt(dx * dx + dy * dy) / R;
      final float r = (_inverted ? 1.0 - rx : rx);
      final float fc = 255 * r;
      final float fa = (_opaque ? 255.0 : fc);
      final float sc = 255 * _linedark * r;
      final float sa = (_opaque ? 255.0 : sc);
      canvas.fill(fc, fa);
      canvas.stroke(sc, sa);
      regions[i].draw(canvas);
    }
  }
}

float randomlog(float low, float high) {
  return low * exp(random(log(high / low)));
}

void circle(float X, float Y, float R) {
  final float density = randomlog(50, 500);
  final float linedark = random(1);
  final boolean inverted = (random(1) < 0.5);
  final boolean opaque = (random(1) < 0.2);
  
  maskcircle(X, Y, R, new VPhyllo(density, linedark, inverted, opaque));
}
