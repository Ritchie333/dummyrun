b $7F00 Buffer for reversing / inverting graphics
w $8000 Logic pattern table
w $800E Logic action
c $801C Action 4 : PRESSLIFT(x). Press a lift button
t $804E Status bar static text
c $808A Empty the tears display
c $80AA Update the tears display
c $80AF Update the full tears display
c $8106 Update the empty tears display
c $8158 Check for any collision, and increase tears if there is any clash
b $8179 Item table
b $81B5 Room table
c $81D3 Count up the jelly babies earned in each room
c $81EB Synchronize the inventory with the carried tables
b $820B Item location tables
D $820B Each entry contains x co-ord, y co-ord, room number
B $820B,$5A,3
w $8265 Game flag table
D $8265 This table contains pairs of pointers to a routine that should
D $8265 be run from this offset, and a memory location with a flag of that value
b $827F Room logic : 00 (Gym)
D $827F IF ATFOOT(80,5D) THEN SWAP
D $827F IF ATHEAD(08,88) AND TESTLIFT(3) THEN MOVE(08,E4,98) : MOVELIFT(3) : PRESSLIFT(3)
D $827F IF ATHEAD(E8,88) THEN MOVE(02,0A,98)
D $827F IF ATHEAD(CE,88) THEN MOVE(01,C6,98)
b $82A7 Room logic : 01 (Gardening)
D $82A7 IF ATFOOT(78,98) THEN SWAP
D $82A7 IF ATHEAD(CE,88) THEN MOVE(00,C6,98)
D $82A7 IF ATHEAD(E8,88) AND TESTLIFT(3) THEN MOVE(08,0A,98) : MOVELIFT(3) : PRESSLIST(3)
b $82C6 Room logic : 02 (Toy Department)
D $82C6 IF ATFOOT(A8,50) AND HAS(17) THEN SWAPFOR(17)
D $82C6 IF ATHEAD(08,88) THEN MOVE(00,E4,98)
D $82C6 IF ATHEAD(E8,88) THEN MOVE(06,22,98)
b $82E2 Room logic : 03 (Cloakroom)
D $82E2 IF ATFOOT(C0,68) THEN SWAP
D $82E2 IF ATHEAD(08,88) THEN MOVE(0A,E4,98)
D $82E2 IF ATHEAD(F0,98) THEN MOVE(10,0A,98)
D $82E2 IF ATHEAD(90,88) AND HAS(1A) AND IS(0A,00) THEN SET(0A,01) : PULL
b $830E Room logic : 04 (Tennis Room)
D $830E IF ATFOOT(70,98) AND WON THEN SWAP
D $830E IF ATHEAD(08,88) THEN MOVE(06,68,98)
D $830E IF ATHEAD(E8,88) THEN MOVE(0F,0A,98)
b $8328 Room logic : 05 (Hi-fi Department)
D $8328 IF ATFOOT(78,98) THEN SWAP
D $8328 IF ATHEAD(00,48) THEN MOVE(06,E4,98)
D $8328 IF ATHEAD(E8,88) THEN MOVE(0A,0A,98)
b $8341 Room logic : 06 (Games room)
D $8341 IF ATFOOT(40,98) THEN SWAP
D $8341 IF ATHEAD(30,88) THEN MOVE(02,E4,98)
D $8341 IF ATHEAD(F0,98) THEN MOVE(05,0F,48)
D $8341 IF ATHEAD(08,88) THEN MOVE(0C,2A,98)
D $8341 IF ATHEAD(70,88) THEN MOVE(04,0A,98)
D $8341 IF ATHEAD(B0,88) AND HAS(0A) AND IS(1,1) THEN MOVE(7,0,40)
b $837A Room logic : 07 (Blitz game)
D $837A IF ATFOOT(E8,98) THEN SWAP
D $837A IF ATHEAD(08,88) THEN MOVE(06,B0,98)
b $838A Room logic : 08 (Lift)
D $838A IF ATHEAD(40,88) THEN MOVELIFT(0) : PRESSLIFT(0)
D $838A IF ATHEAD(68,88) THEN MOVELIFT(1) : PRESSLIFT(1)
D $838A IF ATHEAD(90,88) THEN MOVELIFT(2) : PRESSLIFT(2)
D $838A IF ATHEAD(B8,88) THEN MOVELIFT(3) : PRESSLIFT(3)
D $838A IF ATHEAD(E8,88) AND ISLIFT(3) THEN MOVE(00,0A,98)
D $838A IF ATHEAD(E8,88) AND ISLIFT(2) THEN MOVE(0B,0A,98)
D $838A IF ATHEAD(E8,88) AND ISLIFT(1) THEN MOVE(0E,0A,98)
D $838A IF ATHEAD(E8,88) AND ISLIFT(0) THEN MOVE(13,0A,98)
D $838A IF ATHEAD(08,88) AND ISLIFT(3) THEN MOVE(01,E4,98)
D $838A IF ATHEAD(08,88) AND ISLIFT(2) THEN MOVE(10,E4,98)
D $838A IF ATHEAD(08,88) AND ISLIFT(1) THEN MOVE(12,E4,98)
D $838A IF ATHEAD(08,88) AND ISLIFT(0) THEN MOVE(19,E4,98)
b $8407 Room logic : 09 (Inside Fort)
D $8407 IF ATFOOT(98,40) THEN SWAP
D $8407 IF ATHEAD(00,48) THEN MOVE(12,B8,50)
b $8417 Room logic : 0A (Dalek Room)
b $8418 Room logic : 0B (Furniture)
D $8418 IF ATFOOT(28,70) THEN SWAP
D $8418 IF ATHEAD(08,88) AND TESTLIFT(2) THEN MOVE(08,E4,98) : MOVELIFT(2) : PRESSLIFT(2)
D $8418 IF ATHEAD(E8,88) THEN MOVE(0C,0A,98)
b $8437 Room logic : 0C (Library)
D $8437 IF ATFOOT(90,90) THEN SWAP
D $8437 IF ATHEAD(08,88) THEN MOVE(0B,E4,98)
D $8437 IF ATHEAD(38,88) THEN MOVE(06,0A,98)
D $8437 IF ATHEAD(F0,98) THEN MOVE(10,0F,48)
b $8459 Room logic : 0D (Lost And Found)
D $8459 IF HAS(3) THEN REFRESH SWITCH
D $8459 IF ATHEAD(08,88) THEN MOVE(18,2C,98)
D $8459 IF ATHEAD(D0,70) THEN THROW SWITCH
b $8470 Room logic : 0E (Sports Department)
D $8470 IF ATFOOT(90,98) THEN SWAP
D $8470 IF ATHEAD(08,88) AND TESTLIFT(1) THEN MOVE(08,E4,98) : PRESSLIFT(1) : MOVELIFT(1)
D $8470 IF ATHEAD(E8,88) THEN MOVE(17,0A,98)
D $8470 IF HAS(15) AND IS(2,0) THEN SET(2,1) : INVENTORY
D $8470 IF HAS(0A) AND ATHEAD(68,78) AND IS(1,0) THEN SET(6,1) : SWAP : INVENTORY
b $84AC Room logic : 0F (Sandcastle)
D $84AC IF ATFOOT(78,68) AND HAS(12) THEN SWAPFOR(12)
D $84AC IF ATHEAD(08,88) THEN MOVE(04,E4,98)
D $84AC IF HAS(19) AND HAS(0F) AND IS(4,0) THEN SET(4,1) : INVENTORY
b $84CD Room logic : 10 (Cannon room)
D $84CD IF ATHEAD(00,48) THEN MOVE(0C,E4,98)
D $84CD IF ATHEAD(CE,88) THEN MOVE(1C,C6,98)
D $84CD IF ATHEAD(E8,88) AND TESTLIFT(2) THEN MOVE(08,0A,98) : MOVELIFT(2) : PRESSLIFT(2)
D $84CD IF ATHEAD(40,98) AND IS(7,0) AND HAS(7) AND HAS(1B) THEN SET(7,1) : FIRE
D $84CD IF ATHEAD(00,98) THEN MOVE(17,E4,98)
b $850C Room logic : 11 (Not used)
b $850D Room logic : 12 (Toy Fort)
D $850D IF ATFOOT(38,40) THEN SWAP
D $850D IF ATHEAD(80,88) THEN MOVE(09,94,98)
D $850D IF ATHEAD(F0,98) AND TESTLIFT(1) THEN MOVE(08,0A,98) : PRESSLIFT(1) : MOVELIFT(1)
D $850D IF ATHEAD(00,98) THEN MOVE(17,E4,98)
b $8535 Room logic : 13 (Beds)
D $8535 IF ATFOOT(E8,98) THEN SWAP
D $8535 IF ATHEAD(08,88) AND TESTLIFT(0) THEN MOVE(08,E4,98) : PRESSLIFT(0) : MOVELIFT(0)
D $8535 IF ATFOOT(E8,88) THEN MOVE(18,0A,98)
D $8535 IF HAS(13) AND HAS(1C) AND IS(5,0) THEN SET(5,1) : INVENTORY
b $856B Room logic : 14 (Bottom of lift shaft)
D $856B IF ATHEAD(34,97) THEN MOVE(06,30,98)
D $856B IF ATHEAD(34,8F) THEN MOVE(06,30,98)
D $856B IF ATHEAD(34,87) THEN MOVE(06,30,98)
D $856B IF ATHEAD(34,7F) THEN MOVE(06,30,98)
D $856B IF ATHEAD(C0,97) THEN MOVE(13,C6,98)
D $856B IF ATHEAD(C0,8F) THEN MOVE(13,C6,98)
D $856B IF ATHEAD(C0,87) THEN MOVE(13,C6,98)
D $856B IF ATHEAD(C0,7F) THEN MOVE(13,C6,98)
b $85B4 Room logic : 15 (Wine Cellar)
D $85B4 IF ATFOOT(10,98) THEN SWAP
D $85B4 IF ATHEAD(08,88) THEN MOVE(1B,E4,98)
D $85B4 IF ATHEAD(CE,88) THEN MOVE(13,C6,98)
D $85B4 IF HAS(E) AND HAS(15) AND IS(2,0) THEN SET(2,1) : INVENTORY
b $85DB Room logic : 16 (Lift Shaft)
b $85DC Room logic : 17 (Diningware)
D $85DC IF ATFOOT(58,78) THEN SWAP
D $85DC IF ATHEAD(0,98) THEN MOVE(0E,E4,98)
D $85DC IF ATHEAD(F0,98) THEN MOVE(12,0A,98)
b $85F5 Room logic : 18 (Glove door room)
D $85F5 IF ATFOOT(50,98) THEN SWAP
D $85F5 IF ATHEAD(08,88) THEN MOVE(13,E4,98)
D $85F5 IF ATHEAD(F0,98) THEN MOVE(1C,0F,48)
D $85F5 IF HAS(4) AND ATHEAD(2C,88) THEN MOVE(0D,0A,98)
b $8619 Room logic : 19 (Main entrance)
D $8619 IF ATFOOT(68,98) THEN SWAP
D $8619 IF ATHEAD(7C,88) THEN MOVE(1A,7C,98)
D $8619 IF ATHEAD(E8,88) AND TESTLIFT(0) THEN MOVE(08,0A,98) : PRESSLIFT(0) : MOVELIFT(0)
b $8646 Room logic : 1A (Front door)
D $8646 IF ATFOOT(C0,98) THEN SWAP
D $8646 IF ATHEAD(7C,88) THEN MOVE(19,7C,98)
b $8656 Room logic : 1B (Shooting Gallery)
D $8656 IF ATFOOT(10,48) AND HAS(13) AND IS(5,1) AND IS(6,B) THEN SWAP
D $8656 IF ATHEAD(F0,98) THEN MOVE(15,0A,98)
D $8656 IF ATHEAD(00,98) THEN MOVE(1D,E4,58)
b $8677 Room logic : 1C (Lights)
D $8677 IF ATFOOT(78,98) THEN SWAP
D $8677 IF ATHEAD(00,48) THEN MOVE(18,E4,98)
D $8677 IF ATHEAD(D2,88) THEN MOVE(10,C6,98)
D $8677 IF ATHEAD(E8,88) THEN MOVE(1D,0A,58)
D $8677 IF HAS(13) AND HAS(1C) AND IS(5,0) THEN SET(5,1) : INVENTORY
b $86A7 Room logic : 1D (Swimming pool)
D $86A7 IF ATFOOT(70,30) THEN SWAP
D $86A7 IF ATHEAD(00,58) THEN MOVE(1C,E4,98)
D $86A7 IF ATHEAD(F0,58 THEN MOVE(1B,0A,98) 
c $86C0 Pattern 0 : ATHEAD(x,y)
c $86DD Pattern 1 : ATFOOT(x,y)
c $8701 Function 0 : Handle the boxes in the right hand cupboard with the space hopper.
c $8729 Function C : REFRESH SWITCH. Update the switch in the Lost and Found
c $8733 Function B : PULL. Pull the rope so it extends
c $8755 Function 8 : FIRE. Fire the cannon so it makes a big hole
c $876E Pattern 2 : HAS(x). Match if item x is carried
c $877F Action 5 : Perform custom action x
c $8784 Get a specific game flag
R $8784 HL Points to the flag number
R $8784 DE Hold the address where the flag is
c $8794 Pattern 6 : IS(x,y). Match if flag x is y
c $87A1 Action 6 : SET(x,y). Set flag x to value y
c $87AA Action 0 : SWAPFOR(x) : Swap for a specific object
c $87E8 Play the "item exchanged" sound effect
c $87EE Action 1 : SWAP
c $882D
c $8851 Action 2 : MOVE(room,x,y)
c $8874 Pattern 3 : TESTTLIFT(x).
D $8874 Match if the lift is at floor x, but if not, we'll get a sinking feeling.
c $889E Pattern 5 : WON. Did we win a game in this room?
c $88A8 Action 3 : MOVELIFT(x). Move the lift
c $88B0 Pattern 4 : IS LIFT(x). Match if the lift is at floor x
c $88BD Process a room's logic table
c $88DE
c $88E6
b $88FC
b $8920
c $8940
b $8986 Room data 00
b $89F1 Room data 01
b $8A20 Room data 02
b $8A3A Room data 03
b $8A7F Room data 04
b $8A8C Room data 05
b $8AA0 Room data 06
b $8AB4 Room data 07
b $8ABB Room data 08
b $8ACC Room data 09
b $8AEC Room data 0A
b $8AF7 Room data 0B
b $8B14 Room data 0C
b $8B22 Room data 0D
b $8B33 Room data 0E
b $8B59 Room data 0F
b $8B70 Room data 10
b $8B92 Room data 11
b $8B93 Room data 12
b $8B97 Room data 13
b $8BB4 Room data 14
b $8BB5 Room data 15
b $8BE1 Room data 16
b $8BEB Room data 17
b $8C1C Room data 18
b $8C3F Room data 19
b $8C5F Room data 1A
b $8C6C Room data 1B
b $8C84 Room data 1C
b $8C98 Room data 1D
c $8CA5
c $8D04
b $8D69
c $8D6C 
b $8D8E
t $8E29 "Here come your jelly babies!"
c $8E47 Print the jelly baby message and dump a load on screen
c $8EF5
b $8F04 Graphics : Jelly babies
D $8F04 #UDGARRAY2,$46,,2;$8F04-$8F83-1-16(jellies)
c $8F84 Initialize lives and energy
c $8F92
c $8FCD
c $9008
t $9042 The current time (h:mm)
c $904B Check the time and set the zero flag if it's got to 5:30
c $9062
c $908F
c $9097
c $90F7
c $9104
c $910D
b $9120
c $9144
c $91FE
c $9232
c $9255
c $9263
c $92C0
c $92DF
c $931E
c $932E
c $9338
c $93BC
c $943E Blank the screen
t $9453 Game won message
t $94C7 Game lost message
c $9548 Wait for a key to be pressed
c $955B Wait for a key to be pressed
c $956B Print the number of jelly babies
R $956B D x co-ordinate to print at
R $956B E y co-ordinate to print at
c $959D Print the "game over" screen
c $95BB Main entry point (after theme tune)
c $9616
b $9670
t $9672 "I'm waiting!"
c $96A3
c $96BE
c $96CA See if "pause" is pressed, and act accordingly
b $96E7 Graphics : Herbert (on lift)
D $96E7 #UDGARRAY2,$46,,2;$96E7-$9726-1-16(herbertl)
c $9727
c $975F Function 9 : THROW SWITCH
D $975F Trip the switch in the Lost and Found. Do the ending sequence.
c $97C2 Advance the clock and end the game if we took too long
t $9802 Too long message
c $9887 Fast copy graphics
t $98C8 Control selection text
c $9913 Clear highlighted control selections
c $991F Select the right control that the user wanted
c $994C Print the control selection screen and see if a key was pressed
b $9994
c $9A46
c $9AAF
c $9AF1 A collision has occured. Increase tears. ;-(
b $9B9A
c $9BAB
c $9C25
c $9C65
c $9C69
c $9C72 Put the attribute buffer on screen
c $9C8A
b $9CBE Graphics (music)
D $9CBE #UDGARRAY4,$46,,4;$9CBE-$9D3D-1-32{32}(music)
b $9D3E
b $9D66 Currently active lift button
b $9D6B Current position
b $9D6D
b $9D9A
b $9DC8 Selected control mechanism (0 = Keyboard, 1 = Kempston, 2 = Sinclair)
b $9DAD Number of lives left
b $9DAE
b $9DD1 Current lift floor - 1
b $9DD2
b $9DE2 Character set
b $9E35
b $9F45
c $9F4E Print a FF terminated string
R $9F4E HL Address of the string to print
R $9F4E D y co-ordinate to start printing
R $9F4E E x co-ordinate to start printing
c $A028 
c $A062
t $A07C Item descriptions
c $A220
c $A242 Function 3 : Print the inventory
c $A29A
c $A346 Search for the 'nth' set of data in a buffer
R $A346 HL The start of the buffer. Returns pointing to the data
R $A346 D The nth item to look for
c $A353
b $A3C9
c $A405
c $A40C
c $A410
t $A421 Hidden message
c $A472
c $A473
c $A491
c $A498
c $A49F
c $A4B1
c $A4B5
c $A4B9
c $A4BD
c $A4C1
c $A4D2
c $A4E9
c $A505
c $A509
c $A51C
c $A520
b $A524
c $A528
c $A52C
c $A530
c $A534
c $A538
c $A579
c $A580
c $A5A5
c $A5B5
c $A5D1
c $A5FE
b $A60B
c $A68C
b $A6D0
c $A706
b $A722
c $A770
c $A79B
b $A7C3
c $A883
c $A8B0
c $A8EA
c $A8EE
c $A95B
c $A965
c $A975
b $A9BF
c $A9CA
b $A9F1
b $AA22
b $AAA6
b $AC21
b $AD21
c $AD28
c $AD84
b $ADA1
c $ADE1
c $AE0A
b $AE22
c $AE2E
c $AECF
c $AF09 Play a sound effect
R $AF09 A The number of the sound effect to play
c $AF34 Play a component of a sound effect
c $AF4D Play an edge of a sound component
R $AF4D B The frequency / duration of the sound
b $AF5D Sound effect data
b $AF79
c $AF9F
c $AFAA
c $B003
b $B02E
c $B048
b $B068
c $B070
b $B08F
c $B0B9
b $B0DE
b $B141
c $B174
b $B190
c $B1D9
b $B23C
c $B315
b $B381
c $B491
b $B4C5
c $B4DA
c $B508
b $B537
c $B655
c $B65D
b $B691
c $B7AB
b $B7D4 Graphics (masked)
D $B7D4 #UDGARRAY4,$47,,4;$B7D4-$BA53-1-32{32}(masked)
b $BA54
c $BA5D
c $BA69
c $BAC9
c $BAF0
b $BB6C
c $BD4D
c $BDD6
b $BE39
b $BE47 
b $BE53 Graphics : Herbert (bomb game)
D $BE53 #UDGTABLE { #UDGARRAY2,$46,,2;$BE53-$BE72-1-16(herbertb0) | #UDGARRAY2,$46,,2;$BE73-$BE92-1-16(herbertb1) } TABLE#
c $BE93
b $BF0A
c $BF82
c $BFAD
c $BFC7
c $BFE4
c $C092
c $C0BE
c $C0E9
b $C14E
b $C15E
b $C18E
b $C1C6 Graphics (Dalek game)
D $C1C6 #UDGARRAY2,$45,,2;$C1C6-$C2E5-1-16(dalek)
b $C2E6 Graphics (usable objects)
D $C2E6 #UDGARRAY2,$47,,2;$C2E6-$C505-1-16(objects0)
b $c506
b $C526 (Graphics (usable objects)
D $C526 #UDGARRAY2,$47,,2;$C526-$C5A5-1-16(objects1)
b $C5A6
b $C5C4 Current room
b $C5C5
b $C5C6 Graphics (usable objects)
D $C5C6 #UDGARRAY2,$47,,2;$C5C6-$C6AB-1-16(objects2)
c $C6A6
c $C6CE
c $C6D3
c $C71A
c $C731
c $C78F
c $C7E4
c $C843
c $C872
c $C877
b $C8CF
c $C915
c $CA07
c $CA13
b $CA26
c $CA3F
b $CA8E
b $CA91 Tears energy
b $CAA4 First item carried
b $CAA5 Second item carried
b $CAA6
b $CAA8 Game flags
c $CABF Initialize game data
c $CB25
b $CB56 Block room graphics
D $CB56 #UDGTABLE { #UDGARRAY1,$47,,2;$CB56-$CE55-1-8(blocks0) | #UDGARRAY1,$47,,2;$CE56-$D155-1-8(blocks1) | #UDGARRAY1,$47,,2;$D156-$D355-1-8(blocks2) | #UDGARRAY1,$47,,2;$D356-$D555-1-8(blocks3) | #UDGARRAY1,$47,,2;$D556-$D755-1-8(blocks4) | #UDGARRAY1,$47,,2;$D756-$D955-1-8(blocks5) | #UDGARRAY1,$47,,2;$D956-$DBB5-1-8(blocks6) | } TABLE#
w $DBB6 Room graphic part table

b $E398 Room block graphics 00
b $E3AA Room block graphics 01
b $E3E9 Room block graphics 02
b $E42D Room block graphics 03
b $E442 Room block graphics 04
b $E44F Room block graphics 05
b $E46D Room block graphics 06
b $E51B Room block graphics 07
b $E52C Room block graphics 08
b $E559 Room block graphics 09
b $E57B Room block graphics 0A
b $E606 Room block graphics 0B
b $E67D Room block graphics 0C
b $E45C Room block graphics 0D
b $E7EA Room block graphics 0E
b $E8BA Room block graphics 0F
b $E8CE Room block graphics 10
b $E8DE Room block graphics 11
b $E933 Room block graphics 12
b $E95F Room block graphics 13
b $E976 Room block graphics 14
b $E989 Room block graphics 15
b $EA1A Room block graphics 16
b $E9B3 Room block graphics 17
b $EA41 Room block graphics 18
b $EAD5 Room block graphics 19
b $EAF9 Room block graphics 1A
b $E4D1 Room block graphics 1B
b $E499 Room block graphics 1C
b $E53C Room block graphics 1D
b $E54B Room block graphics 1E
b $EB42 Room block graphics 1F
b $EB72 Room block graphics 20
b $EBBF Room block graphics 21
b $EBE9 Room block graphics 22
b $EE82 Room block graphics 23
b $EEB2 Room block graphics 24
b $EEE8 Room block graphics 25
b $EC30 Room block graphics 26
b $E5FF Room block graphics 27
b $EC23 Room block graphics 28
b $EDC8 Room block graphics 29
b $EE1B Room block graphics 2A
b $EE31 Room block graphics 2B
b $EE3E Room block graphics 2C
b $EE54 Room block graphics 2D
b $E37D Room block graphics 2E
b $E285 Room block graphics 2F
b $E2AA Room block graphics 30
b $E2CA Room block graphics 31
b $E27E Room block graphics 32
b $E38A Room block graphics 33
b $E2DD Room block graphics 34
b $E301 Room block graphics 35
b $EF2A Room block graphics 36
b $EF43 Room block graphics 37
b $EF5B Room block graphics 38
b $EF76 Room block graphics 39
b $EF89 Room block graphics 3A
b $EF9A Room block graphics 3B
b $EFA6 Room block graphics 3C
b $E1C0 Room block graphics 3D
b $E1CB Room block graphics 3E
b $E1E6 Room block graphics 3F
b $E234 Room block graphics 40
b $E258 Room block graphics 41
b $E1A0 Room block graphics 42
b $E12C Room block graphics 43
b $E17E Room block graphics 44
b $8918 Room block graphics 45
b $E115 Room block graphics 46
b $E0C2 Room block graphics 47
b $E09E Room block graphics 48
b $DD11 Room block graphics 49
b $DFEB Room block graphics 4A
b $DF40 Room block graphics 4B
b $DF5F Room block graphics 4C
b $DF36 Room block graphics 4D
b $DEA5 Room block graphics 4E
b $DEAF Room block graphics 4F
b $DEBF Room block graphics 50
b $DED6 Room block graphics 51
b $DEEA Room block graphics 52
b $DF02 Room block graphics 53
b $DF16 Room block graphics 54
b $E08F Room block graphics 55
b $DE22 Room block graphics 56
b $DE56 Room block graphics 57
b $DE5A Room block graphics 58
b $DE5E Room block graphics 59
b $DE62 Room block graphics 5A
b $DE66 Room block graphics 5B
b $DE83 Room block graphics 5C
b $DE93 Room block graphics 5D
b $DD9C Room block graphics 5E
b $DDBB Room block graphics 5F
b $DDD6 Room block graphics 60
b $DDEE Room block graphics 61
b $DD72 Room block graphics 62
b $DCA1 Room block graphics 63
b $DC8B Room block graphics 64
b $DC84 Room block graphics 65
b $DCC3 Room block graphics 66

b $EFB2 Graphics (moving objects)
D $EFB2 #UDGARRAY4,$46,,4;$EFB2-$F231-1-32{32}(graphmove)
b $F232 Graphics (lives)
D $F232 #UDGARRAY2,$46,,2;$F232-$F271-1-16(lives)
b $F272
u $F282
b $F292 Graphics (float)
D $F292 #UDGARRAY2,$46,,2;$F292-$F2A1-1-16(float)
u $F2A2
b $F2B2 Graphics (food)
D $F2B2 #UDGARRAY2,$46,,2;$F2B2-$F311-1-16(food)
u $F312
w $F324
w $F332 Screen offset table
b $F4B2 Graphics : Herbert walking
D $F4B2 #UDGTABLE { #UDGARRAY4,$46,,4;$F4B2-$F531-1-32{32}(herbert0) | #UDGARRAY4,$46,,4;$F532-$F5B1-1-32{32}(herbert1) | #UDGARRAY4,$46,,4;$F5B2-$F631-1-32{32}(herbert2) | #UDGARRAY4,$46,,4;$F632-$F6B1-1-32{32}(herbert3) | #UDGARRAY4,$46,,4;$F6B2-$F731-1-32{32}(herbert4) | #UDGARRAY4,$46,,4;$F732-$F7B1-1-32{32}(herbert5) | #UDGARRAY4,$46,,4;$F7B2-$F831-1-32{32}(herbert6) | #UDGARRAY4,$46,,4;$F832-$F8B1-1-32{32}(herbert7) } TABLE#
b $F8B2 Graphics : Herbert jumping
D $F8B2 #UDGTABLE { #UDGARRAY4,$46,,4;$F8B2-$F931-1-32{32}(herbertj0) | #UDGARRAY4,$46,,4;$F932-$F9B1-1-32{32}(herbertj1) } TABLE#
b $F9B2 Graphics : Herbert climbing
D $F9B2 #UDGTABLE { #UDGARRAY4,$46,,4;$F9B2-$FA31-1-32{32}(herbertc0) | #UDGARRAY4,$46,,4;$FA32-$FAB1-1-32{32}(herbertc1) } TABLE#
b $FAB2 Graphics (tears empty)
D $FAB2 #UDGARRAY4,$45,,4;$FAB2-$FB51-1-32(tears0)
b $FB52 Graphics (tears full)
D $FB52 #UDGARRAY4,$45,,4;$FB52-$FBF1-1-32(tears1)
u $FBF2
c $FC00 Main entry point
t $FC13 "Press any key to continue"
c $FC32 Play the theme tune
b $FC97 Theme tune data
c $FC9B Pause between note frames and check for a keypress
c $FCAF Play a theme tune note
b $FCE1 Theme tune data
b $FD03 Theme tune data
