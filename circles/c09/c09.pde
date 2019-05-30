/*
 * Concentric circles with slightly varying centers.
 */
void circle(float X, float Y, float R) {
  final float reduce = 0.06;
  final float smallest = 3;
  
  float d = 2 * R;
  noFill();
  ellipse(X, Y, d, d);
  if (R > smallest) {
    float theta = random(2 * PI);
    float nx = X + R * reduce * cos(theta);
    float ny = Y + R * reduce * sin(theta);
    circle(nx, ny, R * (1 - reduce));
  }
}
