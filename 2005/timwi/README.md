## To build:

``` <!---sh-->
    make
```


## To use:

``` <!---sh-->
    ./timwi < bf_program
```


## Try:

``` <!---sh-->
    ./try.sh
```


## Judges' remarks:

Unlike most [BF](https://en.wikipedia.org/wiki/Brainfuck) interpreters that we
have been receiving for the last few years, this one, in our opinion, is the
most obfuscated albeit the most discourteous to the language it interprets. A
simple 3-character fix will make it slightly less so.

Quite a few BF programs found on the Net expect byte-based memory, quite a few
exceed the capacity of this interpreter, but there are many that work. Some
small [quines](https://en.wikipedia.org/wiki/Quine_&lpar;computing&rpar;) work, some don't.

Why?


## Author's remarks:

This is an interpreter for the programming language
[BrainFuck](https://en.wikipedia.org/wiki/Brainfuck) (BF).

Input must be provided in the following format: First a sequence of integers
separated by whitespace (this will be the input to the BF program), then a `:`
(colon), then the BF program itself.

You must not pass any command-line arguments.


### Features

* Supports the complete set of 8 BF instructions (`+-<>[].,`).
* Supports the use of alternative characters for some of those instructions.
Use this to obfuscate your BF programs!

    For a challenge, figure out what this obfuscated BF program does:

            J4mzt?Vazexx-20d~&&~AxdUV!x(~Jz&V)x*(P=J)JUN(dizz)xx_!xx'0&{Vz;}&Jj

    It takes two integers as input and outputs one integer.

* Ignores all whitespace (newlines, spaces and tabs) in the input program.


### Limitations

Since the program, naturally, uses `int`s, the calculations must not exceed the
range of an `int`. (But then again, you can use the integer overflow to further
obfuscate your BF programs in creative ways!)

You are limited to 3125 input integers and 3125 instructions. If you exceed
one of these limits, the behaviour is undefined.


### Obfuscations

Some of the superficial obfuscations are pretty obvious: I'm using `#define`s to
make everything look nice and lineal, and the program is merely a recursive
`main()` function with only a single `return` statement which uses nested ternary
operators to make even the pre-processed code unreadable.

However, the more subtle obfuscations relate to the way the program works.
After applying the pre-processing, you will see a lot of `1+1+1`...etc., and
even if you replace these with their result, those numbers will still not
represent (or even relate to) the ASCII codes of the BF instructions.

The program will first read in all the input integers, but it will begin
execution immediately and only read program instructions as they are needed.
Yet there is no global variable storing how far it has read! Perhaps the
hardest thing to figure out is how it finds the matching square brackets.


<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
