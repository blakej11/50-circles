/*
 * Take a metadata file, and create a zoomed rendition of those circles.
 */

void drawcircle(int circnum, int seed) {
  final int xs[] = { 180, 480, 180, 480 };
  final int ys[] = { 180, 180, 480, 480 };
  final int x = xs[circnum];
  final int y = ys[circnum];

  stroke(255);
  randomSeed(seed);
  noiseSeed(seed);
  circle(x, y, 120);
}

/* ------------------------------------------------------------------ */

int density;

void settings() {
  size(660, 660, RENDERER);
  density = 2; // displayDensity();
  pixelDensity(density);
}

void setup() {
  background(0);
  stroke(255);

  BufferedReader input = createReader("metadata.txt");
  if (input != null) {
    try {
      String line = input.readLine();
      String bits[] = split(line, ": ");
      String seeds[] = split(bits[1], ", ");
      input.close();
 
      for (int i = 0; i < 4; i++) {
        drawcircle(i, int(seeds[i]));
      }
    } catch (IOException e) {
      e.printStackTrace();
    }
    get(0, 0, 660 * density, 660 * density).save("double.png");

  } else {
    print("no random seeds found for this sketch\n");
  }
  exit();
}

void draw() {
}
