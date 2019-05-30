void settings() {
  size(960, 960, RENDERER);
  pixelDensity(displayDensity());
}

void setup() {
  background(0);
  stroke(255);
}

void draw() {
}

void mousePressed() {
  circle(mouseX, mouseY, 150);
}
