/*
 * Multi-shaded triangle pattern, using circular mask.
 *
 * P2D gives crisper meetings of triangles.
 */

class Triangles implements Drawcircle {
  float _boxwidth;

  Triangles(float boxwidth) {
    _boxwidth = boxwidth;
  }
  
  void tri(PGraphics canvas, float x1, float y1, float x2, float y2,
      boolean st) {
    color c = int(random(255));
    canvas.fill(c);
    if (st) {
      canvas.stroke(c);
    } else {
      canvas.noStroke();
    }
    canvas.triangle(0, 0, x1, y1, x2, y2);
  }

  void draw(PGraphics canvas, float R) {
    final float dx = _boxwidth / 2;
    final float dy = _boxwidth / 2;
    
    for (float y = 0; y < R * 2 / _boxwidth; y++) {
      for (float x = 0; x < R * 2 / _boxwidth; x++) {
        canvas.pushMatrix();
        canvas.translate((x + 0.5) * _boxwidth, (y + 0.5) * _boxwidth);
        tri(canvas, -dx, -dy,  dx, -dy, true);
        tri(canvas,  dx, -dy,  dx,  dy, true);
        tri(canvas,  dx,  dy, -dx,  dy, true);
        tri(canvas, -dx,  dy, -dx, -dy, false);
        canvas.popMatrix();
      }
    }
  }
}

void circle(float X, float Y, float R) {
  maskcircle(X, Y, R, new Triangles(random(5, 30)));
}
