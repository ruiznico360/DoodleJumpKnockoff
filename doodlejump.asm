#####################################################################
#
# CSC258H5S Fall 2020 Assembly Final Project
# University of Toronto, St. George
#
# Student: Nicolas Ruiz, 1006083122
#
# Bitmap Display Configuration: Tools>Bitmap Display>Connect to MIPS
# - Unit width in pixels: 8
# - Unit height in pixels: 8
# - Display width in pixels: 256
# - Display height in pixels: 256
# - Base Address for Display: 0x10008000 ($gp)
#
# Any additional information:
# - Ensure you also open Tools>Keyboard and Display MMIO Simulator>Connect to MIPS in order to simulate keyboard input
# - To run do Run>Assemble then Run>Go and enjoy!
# - use "s" to start/restart game and use "l" and "j" to move right and left
#####################################################################
.eqv startX 0x03
.eqv startY 0x01
.eqv playerBody 0x1C1C1C
.eqv playerHead 0x909090
.eqv psize 80
.eqv cam 14
.eqv maxjump 36
.eqv govercolor 0xff0000
.eqv normalPlatformColor 0x1C1C1C
.eqv fragilePlatformColor 0x808080
.eqv springPlatformColor 0x699494
.eqv scoreColor 0xFF0001

.macro drawBasicAt(%x, %y, %color)
addi $sp $sp -12
add $a0 $zero %x
add $a1 $zero %y
add $a2 $zero %color
sw $a0 0($sp)
sw $a1 4($sp)
sw $a2 8($sp)
jal SETXY
.end_macro

.macro numHelper(%x, %y)
lw $t1 4($sp) # get pos
addi $t2 $zero 4 # constant 4
mult $t1 $t2
mflo $t1 # 4pos
addi $t2 $zero 32 # get cosntant 31
sub $t1 $t2 $t1 # 31 - 4pos
addi $t2 $t1 %x
drawBasicAt($t2, %y, scoreColor)
.end_macro

.macro drawGameOverText
#N
drawBasicAt(8,22, govercolor)
drawBasicAt(8,21, govercolor)
drawBasicAt(8,20, govercolor)
drawBasicAt(8,19, govercolor)
drawBasicAt(8,18, govercolor)
drawBasicAt(8,17, govercolor)
drawBasicAt(8,16, govercolor)
drawBasicAt(12,22, govercolor)
drawBasicAt(12,21, govercolor)
drawBasicAt(12,20, govercolor)
drawBasicAt(12,19, govercolor)
drawBasicAt(12,18, govercolor)
drawBasicAt(12,17, govercolor)
drawBasicAt(12,16, govercolor)
drawBasicAt(9,20, govercolor)
drawBasicAt(10,19, govercolor)
drawBasicAt(11,18, govercolor)

#E
drawBasicAt(14,22, govercolor)
drawBasicAt(15,22, govercolor)
drawBasicAt(16,22, govercolor)
drawBasicAt(17,22, govercolor)
drawBasicAt(14,21, govercolor)
drawBasicAt(14,20, govercolor)
drawBasicAt(14,19, govercolor)
drawBasicAt(14,18, govercolor)
drawBasicAt(14,17, govercolor)
drawBasicAt(14,16, govercolor)
drawBasicAt(15,16, govercolor)
drawBasicAt(16,16 govercolor)
drawBasicAt(17,16, govercolor)
drawBasicAt(15,19, govercolor)
drawBasicAt(16,19, govercolor)
drawBasicAt(17,19, govercolor)

#W
drawBasicAt(19,22, govercolor)
drawBasicAt(19,21, govercolor)
drawBasicAt(19,20, govercolor)
drawBasicAt(19,19, govercolor)
drawBasicAt(19,18, govercolor)
drawBasicAt(19,17, govercolor)
drawBasicAt(19,16, govercolor)
drawBasicAt(23,22, govercolor)
drawBasicAt(23,21, govercolor)
drawBasicAt(23,20, govercolor)
drawBasicAt(23,19, govercolor)
drawBasicAt(23,18, govercolor)
drawBasicAt(23,17, govercolor)
drawBasicAt(23,16, govercolor)
drawBasicAt(20,17, govercolor)
drawBasicAt(21,18, govercolor)
drawBasicAt(22,17, govercolor)

#G
drawBasicAt(6,14, govercolor)
drawBasicAt(7,14, govercolor)
drawBasicAt(8,14, govercolor)
drawBasicAt(9,14, govercolor)
drawBasicAt(6,13, govercolor)
drawBasicAt(6,12, govercolor)
drawBasicAt(6,11, govercolor)
drawBasicAt(6,10, govercolor)
drawBasicAt(6,9, govercolor)
drawBasicAt(6,8, govercolor)
drawBasicAt(7,8, govercolor)
drawBasicAt(8,8, govercolor)
drawBasicAt(9,8, govercolor)
drawBasicAt(9,9, govercolor)
drawBasicAt(9,10, govercolor)
drawBasicAt(9,11, govercolor)
drawBasicAt(8,11, govercolor)

#A
drawBasicAt(11,14, govercolor)
drawBasicAt(12,14, govercolor)
drawBasicAt(13,14, govercolor)
drawBasicAt(14,14, govercolor)
drawBasicAt(11,13, govercolor)
drawBasicAt(11,12, govercolor)
drawBasicAt(11,11, govercolor)
drawBasicAt(11,10, govercolor)
drawBasicAt(11,9, govercolor)
drawBasicAt(11,8, govercolor)
drawBasicAt(14,13, govercolor)
drawBasicAt(14,12, govercolor)
drawBasicAt(14,11, govercolor)
drawBasicAt(14,10, govercolor)
drawBasicAt(14,9, govercolor)
drawBasicAt(14,8, govercolor)
drawBasicAt(12,11, govercolor)
drawBasicAt(13,11, govercolor)

#M
drawBasicAt(16,14, govercolor)
drawBasicAt(20,14, govercolor)
drawBasicAt(16,13, govercolor)
drawBasicAt(16,12, govercolor)
drawBasicAt(16,11, govercolor)
drawBasicAt(16,10, govercolor)
drawBasicAt(16,9, govercolor)
drawBasicAt(16,8, govercolor)
drawBasicAt(19,13, govercolor)
drawBasicAt(18,12, govercolor)
drawBasicAt(17,13, govercolor)
drawBasicAt(20,13, govercolor)
drawBasicAt(20,12, govercolor)
drawBasicAt(20,11, govercolor)
drawBasicAt(20,10, govercolor)
drawBasicAt(20,9, govercolor)
drawBasicAt(20,8, govercolor)

#E
drawBasicAt(22,14, govercolor)
drawBasicAt(23,14, govercolor)
drawBasicAt(24,14, govercolor)
drawBasicAt(25,14, govercolor)
drawBasicAt(22,13, govercolor)
drawBasicAt(22,12, govercolor)
drawBasicAt(22,11, govercolor)
drawBasicAt(22,10, govercolor)
drawBasicAt(22,9, govercolor)
drawBasicAt(22,8, govercolor)
drawBasicAt(23,8, govercolor)
drawBasicAt(24,8, govercolor)
drawBasicAt(25,8, govercolor)
drawBasicAt(23,11, govercolor)
drawBasicAt(24,11, govercolor)
drawBasicAt(25,11, govercolor)
.end_macro

.data
null: .byte 0 # null pointer
displayAddress: .word 0x10008000
buffer: .space 4096
score: .word 0 # player score
x: .byte startX # player x
y: .byte startY # player y
dir: .byte 1 # player direction left=-1 right=1
platforms: .space psize # array of 20 platform structs {byte x, byte y, byte width, byte type} type={0=fragile, 1 = normal, 2=spring}
platformGenerated: .word 0 # pointer to most recently generated platform
jumpKeeper: .space 12 # array of 3 ints to store jump information {direction(-1 = down 1 = up), counter, enable}

.text
#==============================================================================START CODE=========================================================================================
j DEAD

GAME: la $t0 jumpKeeper # get jump keeper address
addi $t1 $zero -1
addi $t2 $zero 1
addi $t3 $zero maxjump
sb $t1 0($t0) # direction=-1
sb $t3 1($t0) # counter=0
sb $t2 2($t0) # enable=1
addi $t0 $zero startX
sb $t0 x # set startX
addi $t0 $zero startY
sb $t0 y # set startY
sw $zero score # score = 0

#ADD PLATFORMS-------------------------------------------
la $t0 platforms # get address of platform array
FLOOR: addi $t1 $zero 0 # x=0
addi $t2 $zero 0 # y=0
addi $t3 $zero 32 # width = 32
addi $t4 $zero 1 # type is normal=1
sb $t1 0($t0) # set platform x
sb $t2 1($t0) # set platform y
sb $t3 2($t0) # set platform width
sb $t4 3($t0) # set type
sw $t0 platformGenerated # set most recently generated to floor

addi $t1 $t0 psize # platforms[length]
addi $t0 $t0 4 # generate 1:psize platforms
PLOOP: beq $t0 $t1 GAMELOOP # loop through all platforms
addi $sp $sp -8 # make room for platform[length] and platform[i]
sw $t0 0($sp) # store platform address
sw $t1 4($sp) # store platform[length]
jal GENERATEPLATFORM
lw $t0 0($sp) # retrieve platform address
lw $t1 4($sp) # retrieve platform[length]
addi $sp $sp 8 # remove from stack pointer
addi $t0 $t0 4 # i+=4
j PLOOP
#-------------------------------------------------------

GAMELOOP: j CHECKALIVE
#=================================================================================================================================================================================

#FUNCTIONS----------------------------------------------------
SYSOUT: li $v0 1 # print int
syscall 
li $v0 11 # print char
addi $a0 $zero 0xA # prints newline
syscall
jr $ra

SETXY: lw $t0 0($sp) #load x value of pixel
lw $t1 4($sp) # load y value of pixel
lw $t8 8($sp) # get color value
bgt $t0 31 RSETXY # check if x is right of screen
blt $t0 0 RSETXY # check if x is left of screen
bgt $t1 31 RSETXY # check if y is above screen
blt $t1 0 RSETXY # check if y is below screen
ble $t1 26 SETXY_1 # only score can be above 26
bne $t8 scoreColor RSETXY # ^
SETXY_1: addi $t2 $zero 31 # get constant 31 
sub $t1 $t2 $t1 # offset to allow y=0 to be bottom of screen
addi $t2 $t2 1 # get constant of 32
mult $t1 $t2 # get offset to display x
mflo $t1 # get ^
add $t0 $t0 $t1 # add offset to x
addi $t2 $zero 4 # get constant 4
mult $t0 $t2 # get 32 bit (8*4 byte) offset
mflo $t0 #get ^ 
lw $t8 8($sp) # get color value
la $t2 buffer #get buffer address
add $t2 $t2 $t0 # get mem location of pixel
sw $t8 0($t2) # paint mem location specified color
RSETXY: addi $sp $sp 12 #remove x,y, and color from stack
jr $ra

PLATFORMAT: lw $t0 0($sp) #load x value
lw $t1 4($sp) # load y value
addi $sp $sp 4 #remove x,y from stack and leave room for platform address
la $t2 platforms # get platforms address
addi $t3 $t2 psize # platformadress[length]
PLATFORMAT_LOOP: beq $t2 $t3 PLATFORMAT_NULL # loop through platforms
lb $t4 0($t2) # get X value of platform
lb $t5 1($t2) # get Y value of platform
lb $t6 2($t2) # get width of platform
bne $t5 $t1 PLATFORMAT_CONT # continue if y's don't match
bgt $t4 $t0 PLATFORMAT_CONT # continue if platform is right of x
add $t4 $t4 $t6 # x + width
addi $t4 $t4 -1 # adjust x + width - 1
blt $t4 $t0 PLATFORMAT_CONT # continue if platform is left of x
sw $t2 0($sp) # return this platform
j PLATFORMAT_RETURN
PLATFORMAT_CONT: add $t2 $t2 4 # i+=4
j PLATFORMAT_LOOP
PLATFORMAT_NULL: la $t6 null # get null pointer
sw $t6 0($sp)
PLATFORMAT_RETURN: jr $ra

DRAW: lw $t0 displayAddress # get display address
la $t1 buffer # get buffer address
addi $t2 $zero 0 # i = 0
DL: beq $t2 4096 DRAW_RETURN # i<=32^2
add $t3 $t2 $t0 # &displayaddress + i
add $t4 $t2 $t1 # &buffer + i
lw $t5 0($t4) # gets buffer[i]
sw $t5, 0($t3) # displayaddress[i] = buffer[i]
add $t2 $t2 4 # i+=4
j DL # continue loop DL
DRAW_RETURN: jr $ra

GENERATEPLATFORM: lw $t0 0($sp) # get platform address
lw $t1 platformGenerated
lb $t6 0($t1) # get most recent x
lb $t4 2($t1) # get most recent width
lb $t5 3($t1) # get most recent type
lb $t1 1($t1) # get most recent y value
li $v0 42 # rng bounded
li $a0 0 # random num id
li $a1 5 # bound for maximum y displacement 
syscall
add $t2 $a0 $t1 # random y displacement above most recent value
addi $t2 $t2 1 # to prevent overlap
bne $t5 1 GENNORMAL # if previous not normal, make this one normal
li $a0 0 # random num id
li $a1 16 # generate type {0->fragile, 1->spring, 1<=int<16 -> normal}
syscall
beq $a0 0 GENFRAGILE
bgt $a0 1 GENNORMAL
addi $t5 $zero 2 # make type spring=2
li $a0 0 # random num id
add $a1 $zero $t4 # range within previous width
syscall
add $t3 $a0 $t6 # previous x + springoffset
addi $t2 $t1 1 # y = previousY + 1
addi $t4 $zero 1 # width = 1
j GENERATEPLATFORM_END
GENNORMAL: addi $t5 $zero 1 # make type normal=1
li $a0 0 # random num id
li $a1 5 # bound for random width
syscall
addi $t4 $a0 3 # width with range [3-7]
li $a0 0 # random num id
li $a1 32 # bound for random x pos
add $a1 $a1 $t4 # ensure width is on screen
syscall
sub $t3 $a0 $t4 # random x pos from left to right with -width to ensure on screen
addi $t3 $t3 1 
j GENERATEPLATFORM_END
GENFRAGILE: addi $t5 $zero 0 # make type fragile=0
addi $t4 $zero 3 # default width
li $a0 0 # random num id
li $a1 28 # bound for random x pos
syscall
add $t3 $a0 $zero # random x pos with entire platform on screen
j GENERATEPLATFORM_END
GENERATEPLATFORM_END: sb $t3 0($t0) # store new platform x
sb $t2 1($t0) # store new platform y
sb $t4 2($t0) # store new platform width
sb $t5 3($t0) # store platform type
sw $t0 platformGenerated # update new most recent platform
jr $ra

#--------------------------------------------------------------

CHECKALIVE: lb $t0 y # get y pos of player
bgt $t0 0 CHECKALIVE_END # check if player is alive
j DEAD
CHECKALIVE_END: j CHECKINPUT

CHECKINPUT: lw $t8, 0xffff0000 # check if key press
bne $t8 1 CHECKJUMP # if key pressed
lw $t9, 0xffff0004 # get key id pressed
lb $t0 x # load x value of player
CHECK_J: bne $t9 0x6a CHECK_L #check if J is pressed
addi $t1 $zero -1 # get direction
sb $t1 dir # save direction to left=-1
sub $t0 $t0 1 # x--
bge $t0 $zero MVLEFT # skip if on screen
addi $t0 $zero 31 # wrap around to right side
MVLEFT: sb $t0 x # store new x
j CHECKJUMP
CHECK_L: bne $t9 0x6c CHECKJUMP #check if L is pressed
addi $t1 $zero 1 # get direction
sb $t1 dir # save direction to right=1
add $t0 $t0 1 #x++
ble $t0 31 MVRIGHT # skip if on screen
addi $t0 $zero 0 # wrap around to left side
MVRIGHT: sb $t0 x #store new x

CHECKJUMP: lb $t4 x # get player x
lb $t5 y # get player y
addi $t5 $t5 -1 # y--
addi $sp $sp -8
sw $t4 0($sp) # check platform at x
sw $t5 4($sp) # check platform at y-1
jal PLATFORMAT 
lw $t6 0($sp) 
la $t7 null # get null pointer
addi $sp $sp 4
la $t0 jumpKeeper # get jump keeper address
lb $t1 0($t0) # get direction
lb $t2 1($t0) # get counter
lb $t3 2($t0) # get enabled
lb $t4 x # get player x
lb $t5 y # get player y
beq $t3 0 CHECKJUMP_END # continue if enabled
CHECKJUMP_UP: beq $t1 -1 CHECKJUMP_DOWN # if direction is 0 handle down
beq $t2 maxjump CHECKJUMP_GRAVITY # if max jump frames reached go down
j CHECKJUMP_MOVEY
CHECKJUMP_COUNT: add $t2 $t2 $t1 # counter+=direction
sb $t2 1($t0) # save counter
j CHECKJUMP_END
CHECKJUMP_DOWN: beq $t6 $t7 CHECKJUMP_GRAVITY # if platform below continue falling
CHECKJUMP_DOWN_1: lb $t8 3($t6) # load platform type
bne $t8 0 CHECKJUMP_DOWN_1A # if normal then start jumping
FRAGILEPLAT: addi $sp $sp -16 # make room for y, counter and platform address
sw $t6 0($sp) # store platform address
sw $t2 4($sp) # store counter
sw $t5 8($sp) # store player y
sw $t0 12($sp) # jump keeper
jal GENERATEPLATFORM
lw $t2 4($sp) # restore counter
lw $t5 8($sp) # restore player y
lw $t0 12($sp) # restore jump keeper
addi $sp $sp 16 # restore stack pointer
j CHECKJUMP_GRAVITY
CHECKJUMP_DOWN_1A: addi $t1 $zero 1 # make direction up=1
bne $t8 1 SPRINGPLAT # extra boost for spring
addi $t2 $zero -8 # set counter to -8 for normal jump
sb $t1 0($t0) # save direction
j CHECKJUMP_COUNT
SPRINGPLAT: addi $t2 $zero -50 # set counter to -8 for normal jump
sb $t1 0($t0) # save direction
j CHECKJUMP_COUNT
CHECKJUMP_GRAVITY: addi $t1 $zero -1 # make direction down=-1
sb $t1 0($t0) # save direction
j CHECKJUMP_MOVEY
CHECKJUMP_MOVEY: and $t6 $t2 1 # divisible by 2 for timing purposes
bne $t6 0 CHECKJUMP_COUNT # check divisbility, skip if not
bgt $t2 8 CHECKJUMP_J1 # continue to next jump case 
add $t5 $t5 $t1 # y+=direction
j CHECKJUMP_COUNT
CHECKJUMP_J1: and $t6 $t2 3 # divisible by 4 for timing purposes
bne $t6 0 CHECKJUMP_COUNT # check divisibility, skip if not
bgt $t2 24 CHECKJUMP_COUNT # skip
add $t5 $t5 $t1 # y+=direction
j CHECKJUMP_COUNT
CHECKJUMP_END: addi $sp $sp -4 # make room for y change
bgt $t5 cam CAMUPDATE # update cam if y reaches limit
addi $t0 $zero 0 # no change
j CAM_END
CAMUPDATE:  
addi $t1 $zero cam # get cam constant
sub $t0 $t1 $t5 # get distance to cam max
add $t5 $zero $t1 # set y to cam max
lw $t1 score # get score
addi $t1 $t1 1 # add to score
sw $t1 score # save score
CAM_END: sw $t0 0($sp) # add change in y to stack
sb $t5 y # set y
j UPDATEPLATFORMS

UPDATEPLATFORMS: la $t0 platforms # get platforms address
lw $t5 0($sp) # get desired y change
addi $t1 $t0 psize # platformadress[length]
L0: beq $t0 $t1 UPDATEPLATFORMS_END # loop through platforms
lb $t3 1($t0) # get Y value
bge $t3 $zero PMOVE
addi $sp $sp -8 # make room for platform[i] and platform[length]
sw $t0 0($sp) # store platform[i]
sw $t1 4($sp) # store platform[length]
jal GENERATEPLATFORM
lw $t0 0($sp) # restore platform[i]
lw $t1 4($sp) # restore platform length
lw $t5 8($sp) #restore desired y change
addi $sp $sp 8 # restore stack pointer
j UPDATEPLATFORMS_LOOP_END
PMOVE: add $t3 $t3 $t5 # move platform based on cam update
sb $t3 1($t0) # store new y value for platform
UPDATEPLATFORMS_LOOP_END: add $t0 $t0 4 # i+=4
j L0
UPDATEPLATFORMS_END: addi $sp $sp 4 # remove y change from stack

DRAWBG: la $t0, buffer # $t0 stores the base address for display
addi $t1 $zero 0 # i = 0
li $t6, 0xCCCCCC # $t1 stores the red colour code
L: beq $t1 4096 DRAWPLATFORMS # i <= 32^2*4
add $t2 $t1 $t0 #add offset to x value
sw $t6, 0($t2) # paint
addi $t1 $t1 4 # i+=4
j L # continue loop

DRAWPLATFORMS: la $t0 platforms # get platform address
addi $t1 $t0 0 # platformadress[0]
add $t0 $t0 psize # platformadress[length]
addi $t6 $zero 0 # current platform piece
L2: beq $t1 $t0 DRAWPLAYER # loop through platform addresses
L2_0: lb $t2 0($t1) # get x value of platform
lb $t3 1($t1) # get y value of platform
lb $t4 2($t1) # get width value of platform
beq $t6 $t4 L2END # loop through all platform pieces
lb $t7 3($t1) # get platform type
addi $t5 $zero normalPlatformColor # platform color
beq $t7 1 L2_0_INNER # if normal draw normally with loop
addi $t5 $zero springPlatformColor # platform color
beq $t7 2 L2_0_INNER # if spring draw normally with loop
addi $t5 $zero fragilePlatformColor # platform color
bne $t6 1 L2_0_INNER # for jagged drawing of non normal platforms 
addi $t3 $t3 1 # for jagged drawing
L2_0_INNER: add $t2 $t2 $t6 # piece of platform relative to x
addi $sp $sp -24
sw $t2 0($sp) # draw X
sw $t3 4($sp) # draw Y
sw $t5 8($sp) # draw Color
sw $t0 12($sp) # store end of platform array in stack
sw $t1 16($sp) # store pos of platform array in stack
sw $t6 20($sp) # store current platform piece
jal SETXY
lw $t6 8($sp) # retrieve current platform piece
lw $t1 4($sp) # retrieve pos of platform array from stack
lw $t0 0($sp) # retrieve end of platform array from stack
addi $sp $sp 12
add $t6 $t6 1 # piece++
j L2_0
L2END: addi $t1 $t1 4 # i+=4
addi $t6 $zero 0 # current platform piece
j L2

DRAWPLAYER: lb $t0 x # load x value of player
lb $t1 y # load y value of player
addi $t3 $zero playerBody # get player color
addi $sp $sp -12
sw $t0 0($sp)
sw $t1 4($sp)
sw $t3 8($sp)
jal SETXY
lb $t0 x # load x value of player
lb $t1 y # load y value of player
addi $t3 $zero playerBody # get player color
addi $t1 $t1 1 # get body part 1
addi $sp $sp -12
sw $t0 0($sp)
sw $t1 4($sp)
sw $t3 8($sp)
jal SETXY
lb $t0 x # load x value of player
lb $t1 y # load y value of player
addi $t3 $zero playerBody # get player color
addi $t1 $t1 2 # get body part 2
addi $sp $sp -12
sw $t0 0($sp)
sw $t1 4($sp)
sw $t3 8($sp)
jal SETXY
lb $t0 x # load x value of player
lb $t1 y # load y value of player
addi $t3 $zero playerHead # get player color
addi $t1 $t1 3 # get body part 3
addi $sp $sp -12
sw $t0 0($sp)
sw $t1 4($sp)
sw $t3 8($sp)
jal SETXY
lb $t0 x # load x value of player
lb $t1 y # load y value of player
lb $t2 dir # get direction of player
addi $t3 $zero playerBody # get player color
add $t0 $t0 $t2 # get body part 4
addi $t1 $t1 2 # get body part 4
addi $sp $sp -12
sw $t0 0($sp)
sw $t1 4($sp)
sw $t3 8($sp)
jal SETXY

DRAWSCORE: lw $t0 score # get score
li $t1 1 # pos = 1
addi $sp $sp -12 # make room for num, pos, cScore
DRAWSCORE_LOOP: beq $t1 9 GAMEDRAW # 10^8 => 8 digit number displayed
addi $t3 $zero 10 # get constant 10
div $t4 $t0 $t3 # floor(cScore/10)
mult $t4 $t3 # floor(cScore/10) * 10 
mflo $t2
sub $t2 $t0 $t2 # cScore mod 10 to get number to be displayed
add $t0 $zero $t4 # get new cScore
sw $t2 0($sp) # store num to be displayed
sw $t1 4($sp) # store pos to be displayed
sw $t0 8($sp) # store current score left to be analyzed
j DRAWNUM
DRAWSCORE_LOOP_END: lw $t1 4($sp) # restore position
lw $t0 8($sp) # restore cScore
addi $t1 $t1 1 # pos++
j DRAWSCORE_LOOP

DRAWNUM: #t0 = num $t1 = pos {1= ones, 2 = tens e.t.c}
lw $t0 0($sp) # get num
DRAWNUM_0: bne $t0 0 DRAWNUM_1
numHelper(0,27) 
numHelper(0,28)
numHelper(0,29)
numHelper(0,30)
numHelper(0,31)
numHelper(2,27)
numHelper(2,28)
numHelper(2,29)
numHelper(2,30)
numHelper(2,31)
numHelper(1,27)
numHelper(1,31)
j DRAWSCORE_LOOP_END
DRAWNUM_1: bne $t0 1 DRAWNUM_2
numHelper(2,27)
numHelper(2,28)
numHelper(2,29)
numHelper(2,30)
numHelper(2,31)
j DRAWSCORE_LOOP_END
DRAWNUM_2: bne $t0 2 DRAWNUM_3
numHelper(0,31)
numHelper(1,31)
numHelper(2,31)
numHelper(2,30)
numHelper(2,29)
numHelper(1,29)
numHelper(0,29)
numHelper(0,28)
numHelper(0,27)
numHelper(1,27)
numHelper(2,27)
j DRAWSCORE_LOOP_END
DRAWNUM_3: bne $t0 3 DRAWNUM_4
numHelper(0,31)
numHelper(1,31)
numHelper(2,31)
numHelper(2,30)
numHelper(2,29)
numHelper(1,29)
numHelper(0,29)
numHelper(2,28)
numHelper(0,27)
numHelper(1,27)
numHelper(2,27)
j DRAWSCORE_LOOP_END
DRAWNUM_4: bne $t0 4 DRAWNUM_5
numHelper(0,31)
numHelper(0,30)
numHelper(2,31)
numHelper(2,30)
numHelper(2,29)
numHelper(1,29)
numHelper(0,29)
numHelper(2,28)
numHelper(2,27)
j DRAWSCORE_LOOP_END
DRAWNUM_5: bne $t0 5 DRAWNUM_6
numHelper(0,31)
numHelper(1,31)
numHelper(2,31)
numHelper(0,30)
numHelper(2,29)
numHelper(1,29)
numHelper(0,29)
numHelper(2,28)
numHelper(0,27)
numHelper(1,27)
numHelper(2,27)
j DRAWSCORE_LOOP_END
DRAWNUM_6: bne $t0 6 DRAWNUM_7
numHelper(0,31)
numHelper(1,31)
numHelper(2,31)
numHelper(0,30)
numHelper(2,29)
numHelper(1,29)
numHelper(0,29)
numHelper(0,28)
numHelper(0,27)
numHelper(1,27)
numHelper(2,27)
numHelper(2,28)
j DRAWSCORE_LOOP_END
DRAWNUM_7: bne $t0 7 DRAWNUM_8
numHelper(0,31)
numHelper(1,31)
numHelper(2,31)
numHelper(2,30)
numHelper(2,29)
numHelper(2,28)
numHelper(2,27)
j DRAWSCORE_LOOP_END
DRAWNUM_8: bne $t0 8 DRAWNUM_9
numHelper(0,27) 
numHelper(0,28)
numHelper(0,29)
numHelper(0,30)
numHelper(0,31)
numHelper(1,29)
numHelper(2,27)
numHelper(2,28)
numHelper(2,29)
numHelper(2,30)
numHelper(2,31)
numHelper(1,27)
numHelper(1,31)
j DRAWSCORE_LOOP_END
DRAWNUM_9: bne $t0 9 DRAWSCORE_LOOP_END
numHelper(0,27) 
numHelper(2,28)
numHelper(0,29)
numHelper(0,30)
numHelper(0,31)
numHelper(1,29)
numHelper(2,27)
numHelper(2,28)
numHelper(2,29)
numHelper(2,30)
numHelper(2,31)
numHelper(1,27)
numHelper(1,31)
j DRAWSCORE_LOOP_END

GAMEDRAW: jal DRAW

GEND: j GAMELOOP # continue game loop

#--------------------------TITLE SCREEN/DEATH------------------------------
DEAD: drawGameOverText
addi $sp $sp -4 # make room for if s was pressed
jal CHECKINPUT_TITLE
lw $t0 0($sp) # get s was pressed
addi $sp $sp 4 # remove s was pressed from stack
bne $t0 1 DEAD_DRAW # continue if s not pressed
j GAME # start game
DEAD_DRAW: jal DRAW # draw everything
j DEAD

CHECKINPUT_TITLE: lw $t8, 0xffff0000 # check if key press
addi $t0 $zero 0 # default not pressed
bne $t8 1 CHECKINPUT_TITLE_R # if key pressed
lw $t9, 0xffff0004 # get key id pressed
bne $t9 0x73 CHECKINPUT_TITLE_R #check if s is pressed
addi $t0 $zero 1 # S was pressed
CHECKINPUT_TITLE_R: sw $t0 0($sp) #return s pressed
jr $ra
#-------------------------------------------------------------------------------

Exit:
li $v0, 10 # terminate the program gracefully
syscall
