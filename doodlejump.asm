# Demo for painting
#
# Bitmap Display Configuration:
# - Unit width in pixels: 8
# - Unit height in pixels: 8
# - Display width in pixels: 256
# - Display height in pixels: 256
# - Base Address for Display: 0x10008000 ($gp)
#
.eqv startX 0x03
.eqv startY 0x1F
.eqv playerBody 0x1C1C1C
.eqv playerHead 0x909090
.eqv psize 80
.eqv maxjump 38
.eqv govercolor 0xff0000

.macro drawBasicAt(%x, %y, %color)
addi $sp $sp -12
addi $t0 $zero %x
addi $t1 $zero %y
addi $t2 $zero %color
sw $t0 0($sp)
sw $t1 4($sp)
sw $t2 8($sp)
jal SETXY
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
null: .byte 0xdd # null pointer
displayAddress: .word 0x10008000
buffer: .space 4096
x: .byte startX # player x
y: .byte startY # player y
dir: .byte 1 # player direction left=-1 right=1
platforms: .space psize # array of 20 platform structs {byte x, byte y, byte width, byte type}
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

#ADD TEST PLATFORMS-------------------------------------------
la $t0 platforms # get address of platform array
addi $t4 $zero 0 # i=0
TLOOP: beq $t4 19 FLOOR
addi $t1 $zero 0x0E # x=0
addi $t2 $zero 4 # constant 3
mult $t2 $t4 # 3i
mflo $t2 # get 3i
addi $t2 $t2 1 # 3i + 1
addi $t3 $zero 4 # width = 4
sb $t1 0($t0) # set platform x
sb $t2 1($t0) # set platform y
sb $t3 2($t0) # set platform width
addi $t0 $t0 4
addi $t4 $t4 1
j TLOOP
FLOOR: addi $t1 $zero 2 # x=0
addi $t2 $zero 0 # y=0
addi $t3 $zero 30 # width = 32
sb $t1 0($t0) # set platform x
sb $t2 1($t0) # set platform y
sb $t3 2($t0) # set platform width
#-------------------------------------------------------------

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
bgt $t0 31 RSETXY # check if x is right of screen
blt $t0 0 RSETXY # check if x is left of screen
bgt $t1 31 RSETXY # check if y is above screen
blt $t1 0 RSETXY # check if y is below screen
addi $t2 $zero 31 # get constant 31 
sub $t1 $t2 $t1 # offset to allow y=0 to be bottom of screen
addi $t2 $t2 1 # get constant of 32
mult $t1 $t2 # get offset to display x
mflo $t1 # get ^
add $t0 $t0 $t1 # add offset to x
addi $t2 $zero 4 # get constant 4
mult $t0 $t2 # get 32 bit (8*4 byte) offset
mflo $t0 #get ^ 
lw $t1 8($sp) # get color value
la $t2 buffer #get buffer address
add $t2 $t2 $t0 # get mem location of pixel
sw $t1 0($t2) # paint mem location specified color
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
CHECKJUMP_DOWN_1: 
addi $t1 $zero 1 # make direction up=1
addi $t2 $zero -1 # set counter to -1
sb $t1 0($t0) # save direction
j CHECKJUMP_COUNT
CHECKJUMP_GRAVITY: addi $t1 $zero -1 # make direction down=-1
sb $t1 0($t0) # save direction
j CHECKJUMP_MOVEY
j CHECKJUMP_COUNT
CHECKJUMP_END: sb $t5 y # set y
j UPDATEPLATFORMS
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

UPDATEPLATFORMS: la $t0 platforms # get platforms address
addi $t1 $t0 psize # platformadress[length]
L0: beq $t0 $t1 DRAWBG # loop through platforms
lb $t2 0($t0) # get X value
lb $t3 1($t0) # get Y value
bge $t3 $zero PMOVE
addi $t2 $zero 0
addi $t3 $zero 0x1F
PMOVE: addi $t3 $t3 0
sb $t2 0($t0)
sb $t3 1($t0)
add $t0 $t0 4 # i+=4
j L0

DRAWBG: la $t0, buffer # $t0 stores the base address for display
addi $t1 $zero 0 # i = 0
li $t6, 0xCCCCCC # $t1 stores the red colour code
L: beq $t1 4096 DRAWPLAYER # i <= 32^2*4
add $t2 $t1 $t0 #add offset to x value
sw $t6, 0($t2) # paint
addi $t1 $t1 4 # i+=4
j L # continue loop

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

DRAWPLATFORMS: la $t0 platforms # get platform address
addi $t1 $t0 0 # platformadress[0]
add $t0 $t0 psize # platformadress[length]
addi $t6 $zero 0 # current platform piece
L2: beq $t1 $t0 GAMEDRAW # loop through platform addresses
lb $t2 0($t1) # get x value of platform
lb $t3 1($t1) # get y value of platform
lb $t4 2($t1) # get width value of platform
addi $t5 $zero 0x646464 # platform color
L2_0: beq $t6 $t4 L2END # loop through all platform pieces
add $t2 $t2 $t6 # piece of platform relative to x
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
j L2
L2END: addi $t1 $t1 4 # i+=4
addi $t6 $zero 0 # current platform piece
j L2

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
