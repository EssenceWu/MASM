ASSUME CS:CODE, DS:DATA, SS:STACK
DATA   SEGMENT
QUE    DB 'Are you happy?(y/n) ', '$'
ANS1   DB 0DH, 0AH, 'Life is not just about survival, but poetry and distance.', '$'
ANS2   DB 0DH, 0AH, 'Yesterday is painful, today is painful, tomorrow is beautiful.', '$'
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
       MOV AX, 0H
       PUSH AX
       MOV AX, DATA
       MOV DS, AX
       LEA DX, QUE
       MOV AH, 09H
       INT 21H
       MOV AH, 01H
       INT 21H
       CMP AL, 'y'
       JZ  YES
       JNZ NO
YES:   LEA DX, ANS1
       MOV AH, 09H
       INT 21H
       RET
NO:    LEA DX, ANS2
       MOV AH, 09H
       INT 21H
       RET
CODE   ENDS
END    MAIN
