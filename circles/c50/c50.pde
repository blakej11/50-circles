/*
 * Psychedelic/mandala doodling.
 */

void jags(float R, float dr, int period) {
  final float dtheta = TWO_PI / (float(period) * 2);

  beginShape();
  for (int i = 0; i < period; i++) {
    final float theta = float(i) * dtheta * 2;

    vertex((R + dr) * cos(theta), (R + dr) * sin(theta));
    vertex((R - dr) * cos(theta + dtheta), (R - dr) * sin(theta + dtheta));
  }
  endShape(CLOSE);

  if (random(1) > 0.5) {
    ellipse(0, 0, 2 * (R + dr), 2 * (R + dr));
    ellipse(0, 0, 2 * (R - dr), 2 * (R - dr));
  }
  if (random(1) > 0.5) {
    for (int i = 0; i < period * 2; i++) {
      final float theta = float(i) * dtheta;
      ellipse(R * cos(theta), R * sin(theta), 1, 1);
    }
  }
}

void holes(float R, float dr, int period) {
  final float dtheta = TWO_PI / float(period);

  for (int i = 0; i < period; i++) {
    final float theta = (float(i) + 1/2) * dtheta;
    ellipse(R * cos(theta), R * sin(theta), dr, dr);
  }
}

void leaves(float R, float dr, int period) {
  final float dtheta = TWO_PI / float(period);
  final float width = (dtheta * R) * 0.75;
  final int nveins = int(random(4, 7));

  pushMatrix();
  for (int i = 0; i < period; i++) {
    beginShape();
    for (float x = -HALF_PI; x <= HALF_PI; x += 0.05) {
      curveVertex(R + (x / HALF_PI) * dr, cos(x) * (width / 2));
    }
    endShape();
    beginShape();
    for (float x = -HALF_PI; x <= HALF_PI; x += 0.05) {
      curveVertex(R + (x / HALF_PI) * dr, -cos(x) * (width / 2));
    }
    endShape();
    line(R - dr, 0, R + dr, 0);

    for (int v = 1; v < nveins; v++) {
      float sx = (R - dr) + (2 * dr) / float(nveins) * float(v);
      float ex = (R - dr) + (2 * dr) / float(nveins) * float(v + 1);
      float sy = 0;
      float ey = cos((ex - R) / dr * HALF_PI) * (width / 2);
      line(sx, sy, ex, ey);
      line(sx, sy, ex, -ey);
    }

    rotate(dtheta);
  }
  popMatrix();
}

void minarets(float R, float dr, int period) {
  final float dtheta = TWO_PI / float(period);
  final float width = (dtheta * R) * 0.75;

  pushMatrix();
  for (int i = 0; i < period; i++) {
    beginShape();
    for (float x = -HALF_PI; x <= PI; x += 0.05) {
      curveVertex(R + (x / PI) * dr, (1 + cos(x)) * (width / 4));
    }
    endShape();
    beginShape();
    for (float x = -HALF_PI; x <= PI; x += 0.05) {
      curveVertex(R + (x / PI) * dr, (-1 - cos(x)) * (width / 4));
    }
    endShape();
    rotate(dtheta);
  }
  popMatrix();

  final float D = 2 * (R - dr / 2);
  ellipse(0, 0, D, D);
}

void spirals(float R, float dr, int period) {
  final float dtheta = TWO_PI / (float(period) * 2);
  final float width = (dtheta * R) * 0.75 / 2;
  final float winding = TWO_PI * random(3, 6);

  pushMatrix();
  for (int i = 0; i < period * 2; i++) {
    final float sign = ((int(i) % 2) == 0) ? -1.0 : 1.0;

    beginShape();
    curveVertex(R, 0);
    for (float r = 0; r < width; r += width / 100) {
      final float theta = r / width * winding;
      curveVertex(R + r * cos(theta), r * sin(theta) * sign);
    }
    endShape();

    rotate(dtheta);
  }
  popMatrix();
}

void shape(float R, int period) {
  final float r = random(20, R);
  final float dr = (R / 100) * random(3, 10);

  switch (int(random(5))) {
  case 0:
    jags(r, dr, period);
    break;
  case 1:
    holes(r, dr, period);
    break;
  case 2:
    leaves(r, dr, period);
    break;
  case 3:
    minarets(r, dr, period);
    break;
  case 4:
    spirals(r, dr, period);
    break;
  }
}

void circle(float X, float Y, float R) {
  final int period = int(random(10, 30));
  final int nshapes = int(random(20, 60));

  noFill();
  stroke(255, 64);
  pushMatrix();
  translate(X, Y);
  for (int i = 0; i < nshapes; i++) {
    shape(R, period);
  }
  popMatrix();
}
