AFLAGS = -l 

# Set to 1 to use the m4 generated language tables
USE_M4 = 0

ifdef USE_M4
INCS = tempest.inc
else
INCS =
endif

all : tempestv1 tempestv2 tempestv3 tempestp ascii makepirate

ascii : ascii.c
	gcc -o ascii ascii.c -Wall

clean :
	-rm tempestv1.obj tempestv1 tempestv1.lst tempestv1.rom.od tempestv1.rom.od1 tempestv1.rom
	-rm tempestv2.obj tempestv2 tempestv2.lst tempestv2.rom.od tempestv2.rom.od1 tempestv2.rom
	-rm tempestv3.obj tempestv3 tempestv3.lst tempestv3.rom.od tempestv3.rom.od1 tempestv3.rom
	-rm tempestp.obj  tempestp tempestp.lst
	-rm 2048.zeros
	-rm ascii
ifdef USE_M4
	-rm tempest.inc
endif

tempest.inc : tempest.m4
	m4 tempest.m4 > tempest.inc

tempestv1 : tempest.a65 tempestv1.rom $(INCS)
	ca65 $(AFLAGS) -DVER=1 -DPIRATE=0 -DUSE_M4=$(USE_M4) -o tempestv1.obj tempest.a65
	mv tempest.lst tempestv1.lst
	ld65 tempestv1.obj -S 0 -o tempestv1 -C tempest.cfg
	cmp -b tempestv1 tempestv1.rom || ($(MAKE) diffs T=tempestv1 && exit 1)

tempestv2 : tempest.a65 tempestv2.rom $(INCS)
	ca65 $(AFLAGS) -DVER=2 -DPIRATE=0 -DUSE_M4=$(USE_M4) -o tempestv2.obj tempest.a65
	mv tempest.lst tempestv2.lst
	ld65 tempestv2.obj -S 0 -o tempestv2 -C tempest.cfg
	cmp -b tempestv2 tempestv2.rom || ($(MAKE) diffs T=tempestv2 && exit 1)

tempestv3 : tempest.a65 tempestv3.rom $(INCS)
	ca65 $(AFLAGS) -DVER=3 -DPIRATE=0 -DUSE_M4=$(USE_M4) -o tempestv3.obj tempest.a65
	mv tempest.lst tempestv3.lst
	ld65 tempestv3.obj -S 0 -o tempestv3 -C tempest.cfg
	cmp -b tempestv3 tempestv3.rom || ($(MAKE) diffs T=tempestv3 && exit 1)

tempestp : tempest.a65  $(INCS)
	ca65 $(AFLAGS) -DVER=1 -DPIRATE=1 -DUSE_M4=$(USE_M4) -o tempestp.obj tempest.a65
	mv tempest.lst tempestp.lst
	ld65 tempestp.obj -S 0 -o tempestp -C tempest.cfg




tempestv1.od : tempestv1
	od -v --width=1 -t x1 -A x4 tempestv1 > tempestv1.od

tempestv1.od1 : tempestv1.od
	cut -c 8- < tempestv1.od >tempestv1.od1

tempestv1.rom.od : tempestv1.rom
	od -v --width=1 -t x1 -A x4 tempestv1.rom > tempestv1.rom.od

tempestv1.rom.od1 : tempestv1.rom.od
	cut -c 8- < tempestv1.rom.od >tempestv1.rom.od1




tempestv2.od : tempestv2
	od -v --width=1 -t x1 -A x4 tempestv2 > tempestv2.od

tempestv2.od1 : tempestv2.od
	cut -c 8- < tempestv2.od >tempestv2.od1

tempestv2.rom.od : tempestv2.rom
	od -v --width=1 -t x1 -A x4 tempestv2.rom > tempestv2.rom.od

tempestv2.rom.od1 : tempestv2.rom.od
	cut -c 8- < tempestv2.rom.od >tempestv2.rom.od1




tempestv3.od : tempestv3
	od -v --width=1 -t x1 -A x4 tempestv3 > tempestv3.od

tempestv3.od1 : tempestv3.od
	cut -c 8- < tempestv3.od >tempestv3.od1

tempestv3.rom.od : tempestv3.rom
	od -v --width=1 -t x1 -A x4 tempestv3.rom > tempestv3.rom.od

tempestv3.rom.od1 : tempestv3.rom.od
	cut -c 8- < tempestv3.rom.od >tempestv3.rom.od1


diffs :: $(T).od $(T).rom.od
	xxdiff $(T).od $(T).rom.od &

diffs :: $(T).od1 $(T).rom.od1
	xxdiff $(T).od1 $(T).rom.od1 &

2048.zeros :
	dd if=/dev/zero of=2048.zeros count=1 bs=2048 status=noxfer

V1_DIR = roms/ver1/
V2_DIR = roms/ver2/
V3_DIR = roms/ver3/
PIRATE_DIR = roms/Tempest/

.PHONY : makepirate

makepirate : $(PIRATE_DIR)/136002.123

$(PIRATE_DIR)/136002.123 : tempestp
	@echo "Making pirate roms..."
	@(dd if=tempestp of=$(PIRATE_DIR)/136002.123 bs=2048 count=1 skip=6 status=noxfer; \
	dd if=tempestp of=$(PIRATE_DIR)/136002.124 bs=2048 count=1 skip=7 status=noxfer; \
	dd if=tempestp of=$(PIRATE_DIR)/136002.p0 bs=2048 count=1 skip=16 status=noxfer; \
	dd if=tempestp of=$(PIRATE_DIR)/136002.p1 bs=2048 count=1 skip=17 status=noxfer; \
	dd if=tempestp of=$(PIRATE_DIR)/136002.113 bs=2048 count=1 skip=18 status=noxfer; \
	dd if=tempestp of=$(PIRATE_DIR)/136002.114 bs=2048 count=1 skip=19 status=noxfer; \
	dd if=tempestp of=$(PIRATE_DIR)/136002.115 bs=2048 count=1 skip=20 status=noxfer; \
	dd if=tempestp of=$(PIRATE_DIR)/136002.116 bs=2048 count=1 skip=21 status=noxfer; \
	dd if=tempestp of=$(PIRATE_DIR)/136002.117 bs=2048 count=1 skip=22 status=noxfer; \
	dd if=tempestp of=$(PIRATE_DIR)/136002.118 bs=2048 count=1 skip=23 status=noxfer; \
	dd if=tempestp of=$(PIRATE_DIR)/136002.119 bs=2048 count=1 skip=24 status=noxfer; \
	dd if=tempestp of=$(PIRATE_DIR)/136002.120 bs=2048 count=1 skip=25 status=noxfer; \
	dd if=tempestp of=$(PIRATE_DIR)/136002.121 bs=2048 count=1 skip=26 status=noxfer; \
	dd if=tempestp of=$(PIRATE_DIR)/136002.122 bs=2048 count=1 skip=27 status=noxfer; )>/dev/null 2>&1

tempestv1.rom :	2048.zeros \
                $(V1_DIR)/136002.123 \
                $(V1_DIR)/136002.124 \
                $(V1_DIR)/136002.113 \
                $(V1_DIR)/136002.114 \
                $(V1_DIR)/136002.115 \
                $(V1_DIR)/136002.116 \
                $(V1_DIR)/136002.117 \
                $(V1_DIR)/136002.118 \
                $(V1_DIR)/136002.119 \
                $(V1_DIR)/136002.120 \
                $(V1_DIR)/136002.121 \
                $(V1_DIR)/136002.122 
	cat	\
		2048.zeros \
		2048.zeros \
		2048.zeros \
		2048.zeros \
		2048.zeros \
		2048.zeros \
		$(V1_DIR)/136002.123 \
		$(V1_DIR)/136002.124 \
		2048.zeros \
		2048.zeros \
		2048.zeros \
		2048.zeros \
		2048.zeros \
		2048.zeros \
		2048.zeros \
		2048.zeros \
		2048.zeros \
		2048.zeros \
		$(V1_DIR)/136002.113 \
		$(V1_DIR)/136002.114 \
		$(V1_DIR)/136002.115 \
		$(V1_DIR)/136002.116 \
		$(V1_DIR)/136002.117 \
		$(V1_DIR)/136002.118 \
		$(V1_DIR)/136002.119 \
		$(V1_DIR)/136002.120 \
		$(V1_DIR)/136002.121 \
		$(V1_DIR)/136002.122 \
		> tempestv1.rom

tempestv2.rom :	2048.zeros \
		$(V2_DIR)/136002.111 \
		$(V2_DIR)/136002.112 \
		$(V2_DIR)/136002.113 \
		$(V2_DIR)/136002.114 \
		$(V2_DIR)/136002.115 \
		$(V2_DIR)/136002.116 \
		$(V2_DIR)/136002.217 \
		$(V2_DIR)/136002.118 \
		$(V2_DIR)/136002.119 \
		$(V2_DIR)/136002.120 \
		$(V2_DIR)/136002.121 \
		$(V2_DIR)/136002.222 
	cat	\
		2048.zeros \
		2048.zeros \
		2048.zeros \
		2048.zeros \
		2048.zeros \
		2048.zeros \
		$(V2_DIR)/136002.111 \
		$(V2_DIR)/136002.112 \
		2048.zeros \
		2048.zeros \
		2048.zeros \
		2048.zeros \
		2048.zeros \
		2048.zeros \
		2048.zeros \
		2048.zeros \
		2048.zeros \
		2048.zeros \
		$(V2_DIR)/136002.113 \
		$(V2_DIR)/136002.114 \
		$(V2_DIR)/136002.115 \
		$(V2_DIR)/136002.116 \
		$(V2_DIR)/136002.217 \
		$(V2_DIR)/136002.118 \
		$(V2_DIR)/136002.119 \
		$(V2_DIR)/136002.120 \
		$(V2_DIR)/136002.121 \
		$(V2_DIR)/136002.222 \
		> tempestv2.rom

tempestv3.rom :	2048.zeros \
		$(V3_DIR)/136002.138 \
		$(V3_DIR)/136002.133 \
		$(V3_DIR)/136002.134 \
		$(V3_DIR)/136002.235 \
		$(V3_DIR)/136002.136 \
		$(V3_DIR)/136002.237 
	cat	\
		2048.zeros \
		2048.zeros \
		2048.zeros \
		2048.zeros \
		2048.zeros \
		2048.zeros \
		$(V3_DIR)/136002.138 \
		2048.zeros \
		2048.zeros \
		2048.zeros \
		2048.zeros \
		2048.zeros \
		2048.zeros \
		2048.zeros \
		2048.zeros \
		2048.zeros \
		2048.zeros \
		$(V3_DIR)/136002.133 \
		$(V3_DIR)/136002.134 \
		$(V3_DIR)/136002.235 \
		$(V3_DIR)/136002.136 \
		$(V3_DIR)/136002.237 \
		> tempestv3.rom

# 136002.123	; 0x3000
# 136002.124	; 0x3800
# 136002.113	; 0x9000
# 136002.114 	; 0x9800
# 136002.115 	; 0xa000
# 136002.116 	; 0xa800
# 136002.117 	; 0xb000
# 136002.118 	; 0xb800
# 136002.119 	; 0xc000
# 136002.120 	; 0xc800
# 136002.121 	; 0xd000
# 136002.122 	; 0xd800
 
#bintoasc:
#	od -v --width=1 -t x1 -A x4 136002.113 | sed 's/^000/9/' | awk 'NF == 2 {print "l" $$1 "\t.byt\t$$" $$2}' > 0x9000.asm
#	od -v --width=1 -t x1 -A x4 136002.114 | sed 's/^0000/98/;s/^0001/99/;s/^0002/9a/;s/^0003/9b/;s/^0004/9c/;s/^0005/9d/;s/^0006/9e/;s/^0007/9f/' | awk 'NF == 2 {print "l" $$1 "\t.byt\t$$" $$2}' > 0x9800.asm
#	od -v --width=1 -t x1 -A x4 136002.115 | sed 's/^000/a/' | awk 'NF == 2 {print "l" $$1 "\t.byt\t$$" $$2}' > 0xa000.asm
#	od -v --width=1 -t x1 -A x4 136002.116 | sed 's/^0000/a8/;s/^0001/a9/;s/^0002/aa/;s/^0003/ab/;s/^0004/ac/;s/^0005/ad/;s/^0006/ae/;s/^0007/af/' | awk 'NF == 2 {print "l" $$1 "\t.byt\t$$" $$2}' > 0xa800.asm
#	od -v --width=1 -t x1 -A x4 136002.117 | sed 's/^000/b/' | awk 'NF == 2 {print "l" $$1 "\t.byt\t$$" $$2}' > 0xb000.asm
#	od -v --width=1 -t x1 -A x4 136002.118 | sed 's/^0000/b8/;s/^0001/b9/;s/^0002/ba/;s/^0003/bb/;s/^0004/bc/;s/^0005/bd/;s/^0006/be/;s/^0007/bf/' | awk 'NF == 2 {print "l" $$1 "\t.byt\t$$" $$2}' > 0xb800.asm
#	od -v --width=1 -t x1 -A x4 136002.119 | sed 's/^000/c/' | awk 'NF == 2 {print "l" $$1 "\t.byt\t$$" $$2}' > 0xc000.asm
#	od -v --width=1 -t x1 -A x4 136002.120 | sed 's/^0000/c8/;s/^0001/c9/;s/^0002/ca/;s/^0003/cb/;s/^0004/cc/;s/^0005/cd/;s/^0006/ce/;s/^0007/cf/' | awk 'NF == 2 {print "l" $$1 "\t.byt\t$$" $$2}' > 0xc800.asm
#	od -v --width=1 -t x1 -A x4 136002.121 | sed 's/^000/d/' | awk 'NF == 2 {print "l" $$1 "\t.byt\t$$" $$2}' > 0xd000.asm
#	od -v --width=1 -t x1 -A x4 136002.122 | sed 's/^0000/d8/;s/^0001/d9/;s/^0002/da/;s/^0003/db/;s/^0004/dc/;s/^0005/dd/;s/^0006/de/;s/^0007/df/' | awk 'NF == 2 {print "l" $$1 "\t.byt\t$$" $$2}' > 0xd800.asm
#	od -v --width=1 -t x1 -A x4 136002.123 | sed 's/^000/3/' | awk 'NF == 2 {print "l" $$1 "\t.byt\t$$" $$2}' > 0x3000.asm
#	od -v --width=1 -t x1 -A x4 136002.124 | sed 's/^0000/38/;s/^0001/39/;s/^0002/3a/;s/^0003/3b/;s/^0004/3c/;s/^0005/3d/;s/^0006/3e/;s/^0007/3f/' | awk 'NF == 2 {print "l" $$1 "\t.byt\t$$" $$2}' > 0x3800.asm
