#include <stdlib.h>
#include <stdio.h>
#include <string.h>

#define sz 1024

static char image [sz] [sz];

static void clear (void)
  {
    int x, y;
    for (y = 0; y < sz; y ++)
      for (x = 0; x < sz; x ++)
        image [y] [x] = ' ';
  }

static void print (void)
  {
    int x, y;
    int minx = sz, miny = sz, maxx = -1, maxy = -1;

    for (y = 0; y < sz; y ++)
      for (x = 0; x < sz; x ++)
        if (image [y] [x] != ' ')
          {
            if (x < minx)
              minx = x;
            if (y < miny)
              miny = y;
            if (x > maxx)
              maxx = x;
            if (y > maxy)
              maxy = y;
          }
    for (y = maxy; y >= miny; y --)
      {
        printf ("; ");
        for (x = minx; x <= maxx; x ++)
          printf ("%c", image [y] [x]);
        printf ("\n");
      }
  }

static void putpixel (int x, int y, int c)
  {
    //printf ("%d %d %d\n", x, y, c);
    int xp = x + sz / 2;
    int yp = y + sz / 2;
    if (xp < 0 || xp >= sz || yp < 0 || yp >= sz)
      printf ("%d %d %d\n", x, y, c);
    else
      image [yp] [xp] = '*';
  }

static void draw (int x1, int y1, int x2, int y2, int c)
  {
    float x, y, xinc, yinc, dx, dy;
    int k;
    int step;
    dx = x2 - x1;
    dy = y2 - y1;
    if (abs (dx) > abs (dy))
      step = abs (dx);
    else
      step = abs (dy);
    xinc = dx / step;
    yinc = dy / step;
    x = x1;
    y = y1;
    putpixel (x, y, c);
    for (k = 1; k <= step; k++)
      {
        x = x + xinc;
        y = y + yinc;
        putpixel (x, y, c);
      }
  }



int main (int argc, char * argv [])
  {
    char buf [256], cmd [256];
    int p1, p2, p3;

    int x = 0, y = 0;

    int scale = 1;

    char * cp;

    if (argc == 2)
      scale = atoi (argv [1]);
    printf ("%d\n", scale);

    clear ();

    while (! feof (stdin))
      {
        fgets (buf, 256, stdin);
        if ((cp = strstr (buf, "stat")))
          strncpy (cp, "   2", 4);
        sscanf (buf, "%s%d,%d,%d", cmd, & p1, & p2, &p3);
        //printf ("<%s> <%d> <%d> <%d>\n", cmd, p1, p2, p3);
        if (strcmp (cmd, "vsdraw") == 0 || strcmp (cmd, "vldraw") == 0)
          {
            //printf ("draw %d %d %d\n", p1, p2, p3);
            if (p3)
              draw (x/scale, y/scale, (x + p1)/scale, (y + p2)/scale, p3);
            x = x + p1;
            y = y + p2;
          }
      }
    print ();
    return 0;
  }
