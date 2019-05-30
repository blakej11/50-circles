/*
 * Keystrokes used:
 *
 * 1/2/3/4 = select this circle for slot #1/2/3/4
 * r = select this circle; put it in any open slot
 * j = skip to next one
 * k = skip to prev one
 * s = save results to a file (including random seed metadata) and exit
 * q = quit without saving
 */

/*
 * Processing's random() returns very similar values if it starts with
 * adjacent seeds. Java's built-in random is a bit better, so we use that
 * here to introduce some randomness into the seed values.
 */
int getrealseed(int myseed) {
  return (new java.util.Random(myseed).nextInt());
}

void drawcircle(int circnum, int seed, boolean blank) {
  final int xs[] = { 180, 480, 180, 480, 810 };
  final int ys[] = { 180, 180, 480, 480, 330 };
  final int x = xs[circnum];
  final int y = ys[circnum];

  if (blank) {
    fill(0);
    stroke((circnum == 4) ? 255 : 0);
    rectMode(CENTER);
    square(x, y, 300);
  }

  stroke(255);
  randomSeed(getrealseed(seed));
  noiseSeed(getrealseed(seed));
  circle(x, y, 120);
}

/* ------------------------------------------------------------------ */

int curseed;
int[] seeds = new int[4];

void initseed() {
  curseed = 0;
  for (int i = 0; i < 4; i++) {
    seeds[i] = 0;
  }
}

void reseed(int delta) {
  curseed += delta;
}

void saveseed(int i) {
  seeds[i] = curseed;
}

void drawcurrent() {
  drawcircle(4, curseed, true);
}

void drawchosen(int i) {
  drawcircle(i, seeds[i], true);
}

/* ------------------------------------------------------------------ */

int density;

void keyPressed() {
  switch (key) {
  case '1':				// save into slot #1
  case '2':				// save into slot #2
  case '3':				// save into slot #3
  case '4':				// save into slot #4
    saveseed(key - '1');
    drawchosen(key - '1');
    reseed(1);
    drawcurrent();
    break;

  case 'j':				// go up one in the list of options
    reseed(1);
    drawcurrent();
    break;

  case 'k':				// go down one in the list of options
    reseed(-1);
    drawcurrent();
    break;

  case 'r':				// pick an open slot and save it there
    for (int i = 0; i < 4; i++) {
      if (seeds[i] == 0) {
        saveseed(i);
        drawchosen(i);
        reseed(1);
	drawcurrent();
        break;
      }
    }
    break;

  case 's':				// save image and exit
    for (int i = 0; i < 4; i++) {
      if (seeds[i] == 0) {
        println("not saving yet -- some circles are unset");
        return;
      }
    }

    // Redraw and then save the selected parts of the image.
    background(0);
    for (int i = 0; i < 4; i++) {
      drawcircle(i, seeds[i], false);
    }
    get(0, 0, 660 * density, 660 * density).save("full.png");

    // Save the random seeds used to generate this image.
    PrintWriter output = createWriter("metadata.txt");
    output.print("Random seeds:");
    for (int i = 0; i < 4; i++) {
      output.print(" " + getrealseed(seeds[i]) + (i + 1 == 4 ? "\n" : ","));
    }
    output.flush();
    output.close();
    /* FALLTHROUGH */

  case 'q':				// quit without saving
    exit();
  }
}

void settings() {
  size(990, 660, RENDERER);
  density = 1; // displayDensity();
  pixelDensity(density);
}

void setup() {
  background(0);
  stroke(255);
  initseed();
  
  reseed(1);
  drawcurrent();
}

void draw() {
}
