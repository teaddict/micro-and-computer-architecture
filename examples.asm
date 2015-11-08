
----------------------
NOT ALLOWED
----------------------
MOV ES,DS	:segment to segment
MOV BL,AX	:mixed sizes
MOV	CS,AX	:code segment register
MOV AX,'AB'	:invalid
MOV 123H,AX	:invalid
#######################

----------------------
LODS -> works with SI
----------------------

	MOV SI,OFFSET BUFFER
	MOV CX,10H
	CLD
L1:	LODSB					:SI to AL
	LOOP L1

#######################

----------------------
STOS -> works with DI
----------------------

MOV DI,OFFSET BLOCK
MOV CX,100H
CLD
MOV AL,0				:clear AL
REP	STOSB				:save AL to BLOCK

#######################

----------------------------
MOVS -> works with DI and SI
----------------------------

MOV SI,OFFSET LIST1	
MOV DI,OFFSET LIST2
MOV CX,100
CLD					
REP MOVS				:transfer DI = SI


#######################

----------------------
INS -> works with DI
----------------------
MOV DI,OFFSET LIST1
MOV DX,AC3CH			:port I/O
CLD
MOV CX,50
REP INSB				:input string from I/O


#######################

----------------------
OUTS -> works with SI
----------------------
MOV SI,OFFSET ARRAY
MOV DX,AC3CH			:port I/O
CLD
MOV CX,100
REP OUTSB				:output string to I/O


#######################

----------------------
MOVSX AND MOVZX -> 8bit to 16bit
----------------------
BL = 34H
MOVSX CX,BL 			:sign extesion
BL = FF34H

BL = 34H
MOVZX CX,BL 			:zero extesion
BL = 0034H

#######################

----------------------
AND , OR , XOR
----------------------
AL = 25H

set(1) right most three bit 
	0010 0101
OR	0000 0111
RESULT
	0010 0111

clear(0) left most three bit 
	0010 0101
AND	0001 1111
RESULT
	0000 0101

invert 0th and 3th bit
	0010 0101
XOR	0000 1001
RESULT
	0010 1100


#######################


----------------------
TEST and BTC,BTS...
----------------------
AH = 30H , AL = 20H, BL = 20H

TEST AL,BL 			: AL-BL
Z=1 means equal 

BT	AX,4			:carry flag is set because 4th bit is 1


#######################


-----------------------------------------
SCAS -> string scan -> compared AX,AL,EAX
-----------------------------------------

MOV DI,OFFSET BLOCK
MOV CX,100
CLD
MOV AL,'A'			:search 'A'
REPNE SCASB			:repeat while not equal

#######################

----------------------
CMPS -> SI compared with DI
----------------------

MOV SI,OFFSET LINE
MOV DI,OFFSET TABLE
CLD
MOV CX,100
REPE CMPSB			:work like CMP, sets flags
RET

#######################


----------------------
SET -> if condition true
----------------------

MOV AX,5H
MOV BX,4H
CMP AX,BX			:5-4 = 1
SETA BL 			:set if AX ABOVE -> BL = 1 


#######################


----------------------
ENTRY, DESCRIPTOR TABLE, PRIVILEGE
----------------------
DS = 2133H

0010 0001 0011 0011

0th and 1th bit are for privilege level
11 -> LEVEL 3

2th bit is for table
0 -> if G=0 GLOBAL, G=1 LOCAL

rest ist entry
0100 0010 0110 -> 426H
#######################


--------------------------------
copy 12 byte from SOURCE to DEST
--------------------------------

MOV SI,OFFSET SOURCE
MOV DI,OFFSET DEST
MOV CX,12
CLD
REP MOVS

#######################


----------------------------
convert ASCII numbers to BCD
----------------------------

TABLE DB 30H 31H 32H 33H 34H
	  DB 35H 36H 37H 38H 39H

BCD2A	PROC NEAR
		MOV BX,OFFSET TABLE
		XLAT
		RET
BCD2A	ENDP


#######################


----------------------
DX=(BL/CL)*2
----------------------
MOV AL,BL
DIV CL
MUL 2
MOV DX,AX

#######################

----------------------
scan 300H bytes
search 66H
source LIST
----------------------
MOV DI,OFFSET LIST
MOV CX,300H
CLD
MOV AL,66H
REPNE SCASB

#######################


----------------------
scan 100H bytes
count above 42H - UP
count below 42H - BELOW
count equal 42H - EQUAL
----------------------
	MOV DI,OFFSET BLOCK
	MOV UP,0
	MOV DOWN,0
	MOV EQUAL,0
	MOV CX,100H
	CLD
	MOV AL,42H
L1:	SCASB
	JE L3
	JA L2
	INC DOWN
L2:	INC UP
	LOOP L1
L3:	INC EQUAL
	LOOP L1
#######################


----------------------
AX=(DI*SI)/100H
----------------------
MOV AL,SI
MOV BL,DI
MUL BL
MOV BL,100H
DIV BL

#######################


----------------------
TEST and BTC,BTS...
----------------------


#######################