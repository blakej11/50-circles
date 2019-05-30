/*
 * Spotlight pattern, using circular mask.
 */

class Spotlights implements Drawcircle {
  void draw(PGraphics canvas, float R) {
    canvas.noStroke();
    for (int i = 0; i < int(R * 2); i++) {
      float x = random(R * 2);
      float y = random(R * 2);
      float d = random(pow(R * 2, 2.0/3.0));
      canvas.fill(random(255), random(255));
      canvas.ellipse(x, y, d, d);
    }
  }
}

void circle(float X, float Y, float R) {
  maskcircle(X, Y, R, new Spotlights());
}
