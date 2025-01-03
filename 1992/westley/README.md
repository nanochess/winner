## To build:

``` <!---sh-->
    make all
```

There are two alternate versions that relate to the US specifically. See
[Alternate code](#alternate-code) below.


### Bugs and (Mis)features:

The current status of this entry is:

> **STATUS: INABIAF - please DO NOT fix**

For more detailed information see [1992/westley in bugs.html](../../bugs.html#1992_westley).


## To use:

If lost:


``` <!---sh-->
    ./whereami.sh lat long
```

Where `lat` and `long` correspond to your latitude and longitude.

**NOTE**: you **MUST** have a terminal that is **at least 80 columns** for this
to show properly. The `whereami.sh` and `whereami.alt.sh` scripts check this.


## Try:

``` <!---sh-->
    ./try.sh
```


## Alternate code:

The author provided a version for the US which we added in two files: the first
one is fixed to work for clang; the second one is more for show than for use: if
you have your terminal set at 80 columns you will see that the source code
documents itself. The author explains this but what is meant is it will look
like:

> main(l,a,n,d)...<br>
> [A M E R I C A]...

That version, which will not compile with `clang`, is the second alternate
version, [westley.alt2.c](%%REPO_URL%%/1992/westley/westley.alt2.c).


### Alternate build:

``` <!---sh-->
    make alt
```

If you have `gcc` you can also compile the second alternate version, though it
is functionally equivalent to the first. The original limitation where one has
to have a terminal that wraps at 80 columns is unfortunately in this version
because it requires a specific length so if you do not have this it will not
look right; use the first alternate version if you want to see correct output
with wider terminals. To compile the second alternate version:

``` <!---sh-->
    make alt2
```


### Alternate use:

``` <!---sh-->
    ./whereami.alt.sh lat long
```

**NOTE**: this alternative version also needs a terminal with **at least 80
columns**.


### Alternate try:

The [try.sh](%%REPO_URL%%/1992/westley/try.sh) script uses both the original
entry and the alternate code so one can try the same script for both:

``` <!---sh-->
    ./try.sh
```


## Judges' remarks:

Use `-` (negative number) for the south of the equator and/or west of the
meridian.

To find the approximate place where this entry was judged:

``` <!---sh-->
    # If you have at least 80 columns:
    ./whereami.sh 37 -122

    # If you don't have at least 80 columns, try:
    ./whereami 37 -122
```

If you wish to see this on the US map:

``` <!---sh-->
    # Make sure the alt version is built:
    make alt

    # If you have at least 80 columns:
    ./whereami.alt.sh 37 -122

    # If you don't have at least 80 columns, try:
    ./whereami.alt 37 -122
```


## Author's remarks:

Run the program with your latitude & longitude as integer
arguments; it will produce a map made up of `'!'` with the given
position marked with either a `'"'` (if the position is over a `'!'`)
or a `#` (if the position is over a space).  Southern latitudes
and western longitudes are entered as negative numbers.  For
example, to find San Francisco, run with `./whereami 38 -122`.  The
resolution of the map is five degrees horizontally, ten degrees
vertically.  The map is a Mercator projection with equal spacing
of the latitudes, so the areas near the poles are very distorted.
Latitudes near the poles and Antarctica are not shown.

The program requires the ASCII character set, `putchar(3)`, `atoi(3)`,
and a display that auto-wraps at 80 characters(!).  If your display
does not work this way, you will have to massage the output;
for example, you can redirect it to a file and edit it with vi,
which will do auto-wrap for you.

Lint complains that `main()` returns a random value and I'm not
checking the value that `putchar(3)` returns.  Scandalous!

If you run it with fewer than 2 arguments, it will likely
give you an exception, as it will access arguments that
don't exist and characters before a string constant.


### How it works:

The map is printed as one long string of `' '` and `'!'` characters,
with the auto-wrap used to stack up slices of 80.  The map data is
a string; the first character is how many `!`s are printed
(`'A'`=1, `'B'`=2, etc), the second character is how many `' '`s, the
third is how many `!`s, etc.  ASCII characters less than `'A'`
print no characters but still change the polarity, so any map
of `' '`s and `'!'`s is possible.  This is done in the `putchar(3)`
argument as `33^l&1`, where `l` is the character `position+4`; if
`l` is odd, `' '` is printed, if `l` is even, `'!'` is printed.

The position of latitude & longitude is changed into a single
character position within the one long string via the first
expression `d = latitude/10*80 - longitude/5 - offset`. The
latitude is divided by ten because the vertical resolution is
ten degrees, then multiplied by 80 because of the 80 character
wrap (i.e. each ten degrees moves the position up or down one
entire row).  The longitude is divided by five and added, because
five degrees of change moves the location one character.  The signs
are opposite because latitude is decreasing and longitude is
increasing as you go from upper left to lower right.  The offset
is where the origin (latitude=0, longitude=0) is found.

The position counting down to zero changes the `putchar(3)` from
printing (`'!'` or `' '`) to printing (`'"'` or `'#'`).

The `"H E L L O,   W O R L D!"` string inside the data string
prints the line of blanks past [Tierra del
Fuego](https://en.wikipedia.org/wiki/Tierra_del_Fuego) and the last
blank line.  It's just for show, really.

Since the resolution is coarse, a few coastal cities are shown to
be just off the map; this is an unavoidable artifact.  The map
is reasonably accurate.


### Here are some cities you might like to try:

```
    New York            41  -74
    London              52   0
    Moscow              56   38
    New Delhi           29   77
    Sydney              -34   151
    Los Angeles         34  -118
    Paris               45   2
    Rio de Janeiro      -23  -43
    Beijing             40   116
    Tokyo               36   140
```


For a domestic (US) version with higher resolution, try:

``` <!---c-->
    main(l,a,n,d)char**a;{for(d=atoi(a[1])/2*80-atoi(a[2])-2043;
    n="bnaBCOCXdBBHGYdAP[A M E R I C A].AqandkmavX|ELC}BOCd"
    [l++-3];)for(;n-->64;)putchar(!d+++33^l&1);}
```

The code will test the 80-column wrap and document itself if it is
joined together as one 160-character line and listed.  You should see:

``` <!---c-->
    main(l,a,n,d)...
    [A M E R I C A]...
```

...going down the left edge if your terminal auto-wraps at 80 characters.


<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
