/*
 * Code for masking off a circle while saving alpha channel data.
 */

interface Drawcircle {
  /*
   * Draw a pattern onto the specified canvas.
   * The canvas is a square with edge length (2 * R + 1).
   */
  void draw(PGraphics canvas, float R);
}

void maskcircle(float X, float Y, float R, Drawcircle dc) {
  final int side = int(2 * R + 1);

  PGraphics mask = createGraphics(side, side, RENDERER);
  mask.beginDraw();
  mask.background(0, 0);
  mask.noStroke();
  mask.fill(255, 255);
  mask.ellipse(R, R, R * 2, R * 2);
  mask.loadPixels(); // must come before endDraw(), else strange glitches ensue
  mask.endDraw();

  PGraphics canvas = createGraphics(side, side, RENDERER);
  canvas.beginDraw();
  canvas.background(0, 0);
  dc.draw(canvas, R);	// Get the actual pattern.

  /*
   * Apply the mask to the canvas.
   *
   * The straightforward way of doing this would be to call canvas.mask(mask)).
   * But PImage.mask() uses mask's blue channel as canvas's alpha channel, and
   * I want the canvas to be able to specify its own alpha channels, so I'm
   * unfortunately doing this by hand.  This is almost certainly not as fast
   * as some approach that uses native graphics HW, but performance isn't my
   * biggest concern here.
   */
  canvas.loadPixels();
  final int AM = PImage.ALPHA_MASK;
  for (int p = 0; p < canvas.pixelWidth * canvas.pixelHeight; p++) {
    canvas.pixels[p] &= ((mask.pixels[p] & AM) | ~AM);
  }
  canvas.updatePixels();
  canvas.endDraw();

  image(canvas, X - R, Y - R);
}
