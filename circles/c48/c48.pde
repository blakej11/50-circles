/*
 * A constellation, with brightness following catenary curves.
 */

float sinh(float x) {
  return ((exp(x) - exp(-x)) / 2);
}

class VCatenary implements Drawcircle {
  int _points;

  VCatenary(int points) {
    _points = points;
  }
  
  void draw(PGraphics canvas, float R) {
    canvas.fill(255, 2);
    canvas.noStroke();

    for (int i = 0; i < _points; i++) {
      final float cr = random(R);
      final float theta = random(TWO_PI);
      final float x = cr * cos(theta);
      final float y = cr * sin(theta);
      final float a = random(.5, 5);
      final float xr = random(R);

      for (float r = 0; r < xr; ) {
        canvas.ellipse(R + x, R + y, 2 * r, 2 * r);

        /*
         * This is the one tricky part.
         *
	 * The effect is created by drawing circles expanding out from a point,
	 * such that more circle layers lead to more brightness.  I want the
	 * brightness to follow a catenary curve, which has the formula
         * y = a * cosh(x/a). (Here I'm using it in the range [0, 1], where
         * the center of the circle is actually at 1.)  To do that, I'd want
         * the circles to expand at a rate inversely proportional to the
         * derivative of the catenary, which is y = sinh(x/a).
         */
        r += 1 / sinh((1 - r/xr) / a);
      }
    }
  }
}

void circle(float X, float Y, float R) {
  maskcircle(X, Y, R, new VCatenary(int(random(8, 16))));
}
