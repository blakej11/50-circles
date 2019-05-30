/*
 * Create a Gaussian distribution of points around the target radius.
 *
 * Processing already has randomGaussian(), but I wanted to implement
 * this by hand anyway just to make sure it would work.
 */
float random_gaussian() {
  float v1, v2, s;

  do {
    v1 = 2 * random(1) - 1;
    v2 = 2 * random(1) - 1;
    s = v1 * v1 + v2 * v2;
  } while (s >= 1 || s == 0);
  
  return (v1 * sqrt((-2 * log(s)) / s));
}

void circle(float x, float y, float r) {
  stroke(255, 96);
  for (int i = 0; i < 100000; i++) {
    float dr = random_gaussian() * (r/10);
    float theta = random_gaussian() * 2 * PI;
    point(x + (r + dr) * cos(theta), y + (r + dr) * sin(theta));
  }
}
