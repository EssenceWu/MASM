ASSUME CS:CODE, DS:DATA, DS:DATA, SS:STACK
DATA   SEGMENT
DATA   ENDS
STACK  SEGMENT STACK
       DW 8 DUP(?)
STACK  ENDS
CODE   SEGMENT
       MOV AH, 4CH
       INT 21H
MAIN:  MOV AX, STACK
       MOV SS, AX
       MOV SP, 10H
       MOV AX, 0
       PUSH CS
       PUSH AX
       RETF
CODE   ENDS
END    MAIN