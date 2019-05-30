/*
 * A random Voronoi diagram.
 */

// http://leebyron.com/mesh/
import megamu.mesh.*;

class VDiag implements Drawcircle {
  int _cells;

  VDiag(int cells) {
    _cells = cells;
  }
  
  void draw(PGraphics canvas, float R) {
    float[][] points = new float[_cells][2];
    for (int i = 0; i < _cells; i++) {
      float r = sqrt(random(0, R * R));
      float theta = random(TWO_PI);
      points[i][0] = R + r * cos(theta);
      points[i][1] = R + r * sin(theta);
      canvas.point(points[i][0], points[i][1]);
    }
    Voronoi v = new Voronoi(points);

    canvas.fill(255, 16);
    canvas.stroke(255, 64);

    MPolygon[] regions = v.getRegions();
    for (int i = 0; i < regions.length; i++) {
      regions[i].draw(canvas);
    }

    float[][] edges = v.getEdges();
    for (int i = 0; i < edges.length; i++) {
      canvas.line(edges[i][0], edges[i][1], edges[i][2], edges[i][3]);
    }

    canvas.fill(255, 255);
    for (int i = 0; i < _cells; i++) {
      canvas.ellipse(points[i][0], points[i][1], 1, 1);
    }
  }
}

void circle(float X, float Y, float R) {
  maskcircle(X, Y, R, new VDiag(int(random(100, 200))));
}

/* ------------------------------------------------------------------ */
