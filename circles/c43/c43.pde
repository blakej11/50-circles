/*
 * An initial look at Perlin noise.
 */

class VNoise implements Drawcircle {
  float _time;
  float _density;

  VNoise(float time, float density) {
    _time = time;
    _density = density;
  }

  void draw(PGraphics canvas, float R) {
    float incr = R * 2 / _density;
    for (float x = 0; x < R * 2; x += incr) {
      for (float y = 0; y < R * 2; y += incr) {
        float n = noise(x / _density, y / _density, _time);
        canvas.noStroke();
        canvas.fill(255 * n, 255 * n);
        canvas.square(x, y, incr);
      }
    }
  }
}

void circle(float X, float Y, float R) {
  maskcircle(X, Y, R, new VNoise(random(10), random(20, 100)));
}
