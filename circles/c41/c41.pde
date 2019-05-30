/*
 * Basic phyllotaxis, using Voronoi diagrams.
 */

// http://leebyron.com/mesh/
import megamu.mesh.*;

class VPhyllo implements Drawcircle {
  float _density, _linedark;
  boolean _inverted;

  VPhyllo(float density, float linedark, boolean inverted) {
    _density = density;
    _linedark = linedark;
    _inverted = inverted;
  }

  void draw(PGraphics canvas, float R) {
    final int npoints = int(_density * _density);
    final float	phi = (sqrt(5) + 1) / 2;
    final float	alpha = TWO_PI / (phi * phi);
  
    float[][] points = new float[npoints][2];
    for (int n = 1; n < npoints; n++) {
      final float fn = float(n);
      final float r = sqrt(fn) * (R / _density);
      points[n][0] = R + r * cos(fn * alpha);
      points[n][1] = R + r * sin(fn * alpha);
    }
    Voronoi v = new Voronoi(points);

    MPolygon[] regions = v.getRegions();
    for (int i = 0; i < regions.length; i++) {
      final float rx = sqrt(float(i) / float(regions.length));
      final float r = (_inverted ? 1.0 - rx : rx);
      canvas.fill(color(255 * r));
      canvas.stroke(color(255 * _linedark * r));
      regions[i].draw(canvas);
    }
  }
}

void circle(float X, float Y, float R) {
  final float density = random(10, 80);
  final float linedark = random(1);
  final boolean inverted = (random(1) < 0.5);
  
  maskcircle(X, Y, R, new VPhyllo(density, linedark, inverted));
}
