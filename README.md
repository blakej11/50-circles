# Fifty Ways to Draw a Circle

This project is an exploration of generating a circle in fifty different
ways.  You can read about the motivation for the project
[here](https://foo.net/projects/50-circles/).  This was inspired by Manohar
Vanga's [very similar
project](http://sighack.com/post/seventy-five-ways-to-draw-a-circle), but the
code is all my own.

### Implementation notes

The circles are all implemented using the [Java version of
Processing](https://processing.org/). I took one of the ideas 
[(#08)](/circles/c08/) and reimplemented it in the [Javascript version of
Processing](https://p5js.org/), to make a web app that creates [stained glass
window patterns](https://foo.net/projects/glass/).

The source code for each circle is stored in its own directory. Each circle
is meant to stand on its own, and can be used elsewhere, but there are some
source files that are shared between implementations. These shared source
files are stored in the "main" directory:

- [click.pde](/main/click.pde): a very simple `main()` that draws a circle
  centered on whatever point the mouse clicks on.

- [pick.pde](/main/pick.pde): a `main()` that allows you to select four
  nice-looking examples of the current circle implementation.  It creates an
  image file with those four circles, and saves the random seeds used to
  generate them.

- [grow.pde](/main/grow.pde): a `main()` that takes a file containing four
  random seeds, and generates an image that's twice as large as the one
  created by pick.pde.

- [main.pde](/main/main.pde): a symbolic link to one of the three above files.

- [mask.pde](/main/mask.pde): code to apply a circle-shaped mask to an image
  while retaining the image's own alpha channel data. This is needed by seven
  of the circle implementations.

- [JAVA2D.pde](/main/JAVA2D.pde): a line of code indicating that the current
  sketch should use the default (`JAVA2D`) renderer.

- [P2D.pde](/main/P2D.pde): a line of code indicating that the current sketch
  should use the `P2D` renderer.

The files with `main()` routines were useful for development of the circles,
but they are not needed to use the circle code elsewhere.  Each circle must
use exactly one of the renderer files (JAVA2D.pde or P2D.pde) to indicate
which renderer it wants to use; the masking code (mask.pde) uses this
information, and any settings() routine should respect this choice as well.
For some discussion of the differences in renderer behavior, see
[here](https://discourse.processing.org/t/different-behaviors-of-default-vs-p2d-renderer-with-low-alpha-curves/10982).

Three of the sketches ([#40](/circles/c40/), [#41](/circles/c41/),
[#42](/circles/c42/)) use Lee Byron's "Mesh" library to create Voronoi
diagrams. The [web page](https://leebyron.com/mesh/) for the library describes
how to install it.

I added a fourth constraint to my implementation, aside from the three
mentioned in [my description](https://foo.net/projects/50-circles/). Namely, I
wanted each circle to be totally recreatable given a random seed.  The
implementations of `main()` in pick.pde and grow.pde work together on this -
they both seed Processing's random number generators before drawing a given
circle, and pick.pde keeps track of which random seeds it used and stores them
in a text file after it's done. You can see the random seeds used to create
each of the sample images
[here](https://foo.net/projects/50-circles/images/metadata.txt).

### Images

|     |     |
|:---:|:---:|
|[![](https://foo.net/projects/50-circles/images/660/c01.png)](https://foo.net/projects/50-circles/images/1320/c01.png) |[![](https://foo.net/projects/50-circles/images/660/c02.png)](https://foo.net/projects/50-circles/images/1320/c02.png) |
|[![](https://foo.net/projects/50-circles/images/660/c03.png)](https://foo.net/projects/50-circles/images/1320/c03.png) |[![](https://foo.net/projects/50-circles/images/660/c04.png)](https://foo.net/projects/50-circles/images/1320/c04.png) |
|[![](https://foo.net/projects/50-circles/images/660/c05.png)](https://foo.net/projects/50-circles/images/1320/c05.png) |[![](https://foo.net/projects/50-circles/images/660/c06.png)](https://foo.net/projects/50-circles/images/1320/c06.png) |
|[![](https://foo.net/projects/50-circles/images/660/c07.png)](https://foo.net/projects/50-circles/images/1320/c07.png) |[![](https://foo.net/projects/50-circles/images/660/c08.png)](https://foo.net/projects/50-circles/images/1320/c08.png) |
|[![](https://foo.net/projects/50-circles/images/660/c09.png)](https://foo.net/projects/50-circles/images/1320/c09.png) |[![](https://foo.net/projects/50-circles/images/660/c10.png)](https://foo.net/projects/50-circles/images/1320/c10.png) |
|[![](https://foo.net/projects/50-circles/images/660/c11.png)](https://foo.net/projects/50-circles/images/1320/c11.png) |[![](https://foo.net/projects/50-circles/images/660/c12.png)](https://foo.net/projects/50-circles/images/1320/c12.png) |
|[![](https://foo.net/projects/50-circles/images/660/c13.png)](https://foo.net/projects/50-circles/images/1320/c13.png) |[![](https://foo.net/projects/50-circles/images/660/c14.png)](https://foo.net/projects/50-circles/images/1320/c14.png) |
|[![](https://foo.net/projects/50-circles/images/660/c15.png)](https://foo.net/projects/50-circles/images/1320/c15.png) |[![](https://foo.net/projects/50-circles/images/660/c16.png)](https://foo.net/projects/50-circles/images/1320/c16.png) |
|[![](https://foo.net/projects/50-circles/images/660/c17.png)](https://foo.net/projects/50-circles/images/1320/c17.png) |[![](https://foo.net/projects/50-circles/images/660/c18.png)](https://foo.net/projects/50-circles/images/1320/c18.png) |
|[![](https://foo.net/projects/50-circles/images/660/c19.png)](https://foo.net/projects/50-circles/images/1320/c19.png) |[![](https://foo.net/projects/50-circles/images/660/c20.png)](https://foo.net/projects/50-circles/images/1320/c20.png) |
|[![](https://foo.net/projects/50-circles/images/660/c21.png)](https://foo.net/projects/50-circles/images/1320/c21.png) |[![](https://foo.net/projects/50-circles/images/660/c22.png)](https://foo.net/projects/50-circles/images/1320/c22.png) |
|[![](https://foo.net/projects/50-circles/images/660/c23.png)](https://foo.net/projects/50-circles/images/1320/c23.png) |[![](https://foo.net/projects/50-circles/images/660/c24.png)](https://foo.net/projects/50-circles/images/1320/c24.png) |
|[![](https://foo.net/projects/50-circles/images/660/c25.png)](https://foo.net/projects/50-circles/images/1320/c25.png) |[![](https://foo.net/projects/50-circles/images/660/c26.png)](https://foo.net/projects/50-circles/images/1320/c26.png) |
|[![](https://foo.net/projects/50-circles/images/660/c27.png)](https://foo.net/projects/50-circles/images/1320/c27.png) |[![](https://foo.net/projects/50-circles/images/660/c28.png)](https://foo.net/projects/50-circles/images/1320/c28.png) |
|[![](https://foo.net/projects/50-circles/images/660/c29.png)](https://foo.net/projects/50-circles/images/1320/c29.png) |[![](https://foo.net/projects/50-circles/images/660/c30.png)](https://foo.net/projects/50-circles/images/1320/c30.png) |
|[![](https://foo.net/projects/50-circles/images/660/c31.png)](https://foo.net/projects/50-circles/images/1320/c31.png) |[![](https://foo.net/projects/50-circles/images/660/c32.png)](https://foo.net/projects/50-circles/images/1320/c32.png) |
|[![](https://foo.net/projects/50-circles/images/660/c33.png)](https://foo.net/projects/50-circles/images/1320/c33.png) |[![](https://foo.net/projects/50-circles/images/660/c34.png)](https://foo.net/projects/50-circles/images/1320/c34.png) |
|[![](https://foo.net/projects/50-circles/images/660/c35.png)](https://foo.net/projects/50-circles/images/1320/c35.png) |[![](https://foo.net/projects/50-circles/images/660/c36.png)](https://foo.net/projects/50-circles/images/1320/c36.png) |
|[![](https://foo.net/projects/50-circles/images/660/c37.png)](https://foo.net/projects/50-circles/images/1320/c37.png) |[![](https://foo.net/projects/50-circles/images/660/c38.png)](https://foo.net/projects/50-circles/images/1320/c38.png) |
|[![](https://foo.net/projects/50-circles/images/660/c39.png)](https://foo.net/projects/50-circles/images/1320/c39.png) |[![](https://foo.net/projects/50-circles/images/660/c40.png)](https://foo.net/projects/50-circles/images/1320/c40.png) |
|[![](https://foo.net/projects/50-circles/images/660/c41.png)](https://foo.net/projects/50-circles/images/1320/c41.png) |[![](https://foo.net/projects/50-circles/images/660/c42.png)](https://foo.net/projects/50-circles/images/1320/c42.png) |
|[![](https://foo.net/projects/50-circles/images/660/c43.png)](https://foo.net/projects/50-circles/images/1320/c43.png) |[![](https://foo.net/projects/50-circles/images/660/c44.png)](https://foo.net/projects/50-circles/images/1320/c44.png) |
|[![](https://foo.net/projects/50-circles/images/660/c45.png)](https://foo.net/projects/50-circles/images/1320/c45.png) |[![](https://foo.net/projects/50-circles/images/660/c46.png)](https://foo.net/projects/50-circles/images/1320/c46.png) |
|[![](https://foo.net/projects/50-circles/images/660/c47.png)](https://foo.net/projects/50-circles/images/1320/c47.png) |[![](https://foo.net/projects/50-circles/images/660/c48.png)](https://foo.net/projects/50-circles/images/1320/c48.png) |
|[![](https://foo.net/projects/50-circles/images/660/c49.png)](https://foo.net/projects/50-circles/images/1320/c49.png) |[![](https://foo.net/projects/50-circles/images/660/c50.png)](https://foo.net/projects/50-circles/images/1320/c50.png) |
