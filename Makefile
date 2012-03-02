AFLAGS = 

all : tempestv1.obj tempestv2.obj tempestv3.obj tempestp.obj ascii




ascii : ascii.c
	gcc -o ascii ascii.c -Wall




clean :
	-rm tempestp.obj tempestv1.obj tempestv2.obj tempestv3.obj
	-rm tempestp.lis tempestv1.lis tempestv2.lis tempestv3.lis
	-rm tempestv1.obj.od tempestv2.obj.od tempestv3.obj.od
	-rm tempestv1.obj.od1 tempestv2.obj.od1 tempestv3.obj.od1
	-rm tempestv1.rom tempestv2.rom tempestv3.rom
	-rm tempestv1.rom.od tempestv2.rom.od tempestv3.rom.od
	-rm tempestv1.rom.od1 tempestv2.rom.od1 tempestv3.rom.od1
	-rm 2048.zeros ascii



#
# .obj targets
#

tempestv1.obj : tempest.a65 tempestv1.rom
	atasm $(AFLAGS) -DVER=1 -DPIRATE=0 -f0 -s -r -otempestv1.obj tempest.a65 > tempestv1.lis
	cmp -b tempestv1.obj tempestv1.rom || ($(MAKE) diffs1 diffs11 && exit 1)

tempestp.obj : tempest.a65 
	atasm $(AFLAGS) -DVER=1 -DPIRATE=1 -f0 -s -r -otempestp.obj tempest.a65 > tempestp.lis

tempestv2.obj : tempest.a65 tempestv2.rom
	atasm $(AFLAGS) -DVER=2 -DPIRATE=0 -f0 -s -r -otempestv2.obj tempest.a65 > tempestv2.lis
	cmp -b tempestv2.obj tempestv2.rom || ($(MAKE) diffs2 diffs21 && exit 1)

tempestv3.obj : tempest.a65 tempestv3.rom
	atasm $(AFLAGS) -DVER=3 -DPIRATE=0 -f0 -s -r -otempestv3.obj tempest.a65 > tempestv3.lis
	cmp -b tempestv3.obj tempestv3.rom || ($(MAKE) diffs3 diffs31 && exit 1)

#
# .od targets
#

tempestv1.obj.od : tempestv1.obj
	od -v --width=1 -t x1 -A x4 tempestv1.obj > tempestv1.obj.od

tempestv1.obj.od1 : tempestv1.obj.od
	cut -c 8- < tempestv1.obj.od >tempestv1.obj.od1

tempestv1.rom.od : tempestv1.rom
	od -v --width=1 -t x1 -A x4 tempestv1.rom > tempestv1.rom.od

tempestv1.rom.od1 : tempestv1.rom.od
	cut -c 8- < tempestv1.rom.od >tempestv1.rom.od1




tempestv2.obj.od : tempestv2.obj
	od -v --width=1 -t x1 -A x4 tempestv2.obj > tempestv2.obj.od

tempestv2.obj.od1 : tempestv2.obj.od
	cut -c 8- < tempestv2.obj.od >tempestv2.obj.od1

tempestv2.rom.od : tempestv2.rom
	od -v --width=1 -t x1 -A x4 tempestv2.rom > tempestv2.rom.od

tempestv2.rom.od1 : tempestv2.rom.od
	cut -c 8- < tempestv2.rom.od >tempestv2.rom.od1




tempestv3.obj.od : tempestv3.obj
	od -v --width=1 -t x1 -A x4 tempestv3.obj > tempestv3.obj.od

tempestv3.obj.od1 : tempestv3.obj.od
	cut -c 8- < tempestv3.obj.od >tempestv3.obj.od1

tempestv3.rom.od : tempestv3.rom
	od -v --width=1 -t x1 -A x4 tempestv3.rom > tempestv3.rom.od

tempestv3.rom.od1 : tempestv3.rom.od
	cut -c 8- < tempestv3.rom.od >tempestv3.rom.od1


#
# diff targets
#


diffs1 : tempestv1.obj.od tempestv1.rom.od
	xxdiff tempestv1.obj.od tempestv1.rom.od &

diffs11 : tempestv1.obj.od1 tempestv1.rom.od1
	xxdiff tempestv1.obj.od1 tempestv1.rom.od1 &



diffs2 : tempestv2.obj.od tempestv2.rom.od
	xxdiff tempestv2.obj.od tempestv2.rom.od &

diffs21 : tempestv2.obj.od1 tempestv2.rom.od1
	xxdiff tempestv2.obj.od1 tempestv2.rom.od1 &



diffs3 : tempestv3.obj.od tempestv3.rom.od
	xxdiff tempestv3.obj.od tempestv3.rom.od &

diffs31 : tempestv3.obj.od1 tempestv3.rom.od1
	xxdiff tempestv3.obj.od1 tempestv3.rom.od1 &




2048.zeros :
	dd if=/dev/zero of=2048.zeros count=1 bs=2048



V1_DIR = roms/ver1/
V2_DIR = roms/ver2/
V3_DIR = roms/ver3/
PIRATE_DIR = roms/Tempest/

#
# Generate rom files from pirate version of the code
#

makepirate : tempestp.obj
	dd if=tempestp.obj of=$(PIRATE_DIR)/136002.123 bs=2048 count=1 skip=6
	dd if=tempestp.obj of=$(PIRATE_DIR)/136002.124 bs=2048 count=1 skip=7
	dd if=tempestp.obj of=$(PIRATE_DIR)/136002.113 bs=2048 count=1 skip=18
	dd if=tempestp.obj of=$(PIRATE_DIR)/136002.114 bs=2048 count=1 skip=19
	dd if=tempestp.obj of=$(PIRATE_DIR)/136002.115 bs=2048 count=1 skip=20
	dd if=tempestp.obj of=$(PIRATE_DIR)/136002.116 bs=2048 count=1 skip=21
	dd if=tempestp.obj of=$(PIRATE_DIR)/136002.117 bs=2048 count=1 skip=22
	dd if=tempestp.obj of=$(PIRATE_DIR)/136002.118 bs=2048 count=1 skip=23
	dd if=tempestp.obj of=$(PIRATE_DIR)/136002.119 bs=2048 count=1 skip=24
	dd if=tempestp.obj of=$(PIRATE_DIR)/136002.120 bs=2048 count=1 skip=25
	dd if=tempestp.obj of=$(PIRATE_DIR)/136002.121 bs=2048 count=1 skip=26
	dd if=tempestp.obj of=$(PIRATE_DIR)/136002.122 bs=2048 count=1 skip=27

#
# Generate 65Kb memory image files from rom images
#

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
