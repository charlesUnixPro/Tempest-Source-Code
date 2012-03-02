The make file compares the assembled source code againist the ROM image
files to detect reverse engineering errors. The ROM image files are
copyrighted and must be obtained seperately.

The source code use conditional assembly to generate version 1, 2 and 3
builds. The ROM reference files for the versions are stored in roms/ver1,
roms/ver2 and rom3/ver3.

The build process also builds a "pirate version", which is version 1 with
all of the known copy protection code disabled. (The copy dectection code
still executes, but the code that is executed on detection of piracy is
replaced with noops.) The make target "makepirate" will generate ROM image 
files for the built code which can then be used with emulators or burned to 
ROM chips.

The "ascii" program reads a string of "vsdraw" and "vldraw" commands (pasted
from the source code) and produces an ASCII art drawing.

Files:

	tempest.a65	Source code
	Makefile
	ascii.c		Source code for program to convert vsdraw/vldraw
			to ASCII art
	README.txt	This file

Needed tools:

	The Tempest ROM image files, used to compare the reversed engineered
	source againist the original code. The neeeded files are:

                roms/ver1/136002.123
                roms/ver1/136002.124
                roms/ver1/136002.113
                roms/ver1/136002.114
                roms/ver1/136002.115
                roms/ver1/136002.116
                roms/ver1/136002.117
                roms/ver1/136002.118
                roms/ver1/136002.119
                roms/ver1/136002.120
                roms/ver1/136002.121
                roms/ver1/136002.122`

		roms/ver2/136002.111
                roms/ver2/136002.112
                roms/ver2/136002.113
                roms/ver2/136002.114
                roms/ver2/136002.115
                roms/ver2/136002.116
                roms/ver2/136002.217
                roms/ver2/136002.118
                roms/ver2/136002.119
                roms/ver2/136002.120
                roms/ver2/136002.121
                roms/ver2/136002.222

		roms/ver3/136002.138
                roms/ver3/136002.133
                roms/ver3/136002.134
                roms/ver3/136002.235
                roms/ver3/136002.136
                roms/ver3/136002.237

	atasm: A 6502 assembler. I use the Fedora atasm-1.07d-2.fc15.i686
	distribution. See http://atari.miribilist.com/atasm/

	xxdiff: A 'diff' program with excellent visualization. I use
	the Fedora xxdiff-3.2-14.fc15.i686 distribution. See 
	http://furius.ca/xxdiff/


