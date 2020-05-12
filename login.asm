ASSUME CS:CODE, DS:DATA, SS:STACK
DATA SEGMENT
    USERNAME DB 'admin'
    COUNT1 EQU $-USERNAME
    PASSWORD DB '123456'
    COUNT2 EQU $-PASSWORD
    BUFF1 DB 15, ?, 15 DUP(?)
    BUFF2 DB 15, ?, 15 DUP(?)      
    MSG1 DB '|***************Username***************|:', 0DH, 0AH, '$'
    MSG2 DB '|***************Password***************|:', 0DH, 0AH, '$'
    MSG3 DB 'Username or password error!', 0DH, 0AH, '$'
    MSG4 DB '[ Home | Account | Logout ]', 0DH, 0AH, '$'
DATA ENDS
STACK SEGMENT STACK
STACK ENDS
CODE SEGMENT
    MAIN:
        MOV AX, DATA
        MOV DS, AX

        LEA DX, MSG1
        MOV AH, 09H
        INT 21H
        LEA DX, BUFF1
        MOV AH, 0AH
        INT 21H

        LEA DX, MSG2
        MOV AH, 09H
        INT 21H
        LEA DX, BUFF2
        MOV AH, 0AH
        INT 21H

        CMP BYTE PTR BUFF1+1, COUNT1
	    JNZ ERROR
        CMP BYTE PTR BUFF2+1, COUNT2
	    JNZ ERROR

        MOV AX, DATA
        MOV ES, AX
        LEA SI, USERNAME
        LEA DI, BUFF1+2
        MOV CX, COUNT1
        CLD
        REPE CMPSB
        JNZ ERROR

        MOV AX, DATA
        MOV ES, AX
        LEA SI, PASSWORD
        LEA DI, BUFF2+2
        MOV CX, COUNT2
        CLD
        REPE CMPSB
        JNZ ERROR

    SUCCESS:
        LEA DX, MSG4
        MOV AH, 09H
        INT 21H
        JMP EXIT

    ERROR:
        LEA DX, MSG3
        MOV AH, 09H
        INT 21H
        JMP EXIT

    EXIT:
        MOV AH, 4CH
        INT 21H
CODE ENDS
    END MAIN