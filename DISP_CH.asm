
DATA SEGMENT
    CHAR DB "你好",'$'
DATA ENDS

STACK SEGMENT STACK
    DB 100 DUP(0)
STACK ENDS

CODE SEGMENT CODE 'code'
    ASSUME DS:DATA,CS:CODE
    HZ MACRO X,Y,CHAR,COLOR
    LOCAL DATASEGMENT,HZK,START,HZKHD,HZBUF,ASCTOQW,STRING
    LOCAL CODESEGMENT,XPOINTER,YPOINTER,INIT,EXIT
    LOCAL INIT1,INIT2,NEXT,NEXT1,NEXT2,INIT3
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    PUSH SI
    PUSH DI
    PUSH BP
    PUSH DS
    PUSH ES
    JMP START

DATASEGMENT:
    XPOINTER DW X
    YPOINTER DW Y
    HZK:     DB 'HZK16',0
    HZKHD:   DW ?
    HZBUF:   DB 32 DUP (0)
    STRING:  DB CHAR,0,255

CODESEGMENT:
START:
    MOV AX,CS
    MOV DS,AX
    MOV ES,AX
    MOV AH,3DH          ;
    LEA DX,HZK          ; OPEN HZK
    MOV AL,0            ;
    INT 21H             ;
    LEA SI,HZKHD        ; SAVE FILE HZK16 HELDER
    MOV [SI],AX         ;

    LEA SI,STRING
ASCTOQW:
    MOV AL,[SI]
    CMP AL,0
    JZ  INIT
    SUB AL,161
    MOV [SI],AL
    INC SI
    JMP ASCTOQW

INIT:
    LEA SI,STRING
init1:
    push si
    MOV AL,[SI]
    CMP AL,0
    JNZ INIT2
    LEA BX,EXIT
    JMP BX
INIT2:
    MOV AH,0
    MOV BH,0
    MOV BL,94
    MUL BL
    INC SI
    MOV BL,[SI]
    MOV BH,0
    ADD AX,BX
    MOV BX,32
    MUL BX
    MOV CX,DX
    MOV DX,AX
    LEA SI,HZKHD
    MOV BX,[SI]
    MOV AH,42H
    MOV AL,0
    INT 21H

    LEA SI,HZKHD
    MOV BX,[SI]
    LEA DX,HZBUF
    MOV CX,32
    MOV AH,3FH
    INT 21H
    PUSH AX          ; PSET ONE HANZI
    PUSH BX          ;
    PUSH CX          ;
    PUSH DX          ;
    PUSH SI          ;
    PUSH DI          ;
    PUSH BP          ;
    LEA SI,XPOINTER  ;
    MOV CX,[SI]      ;
    LEA SI,YPOINTER  ;
    MOV DX,[SI]      ;
    MOV DI,CX        ;
    ADD DI,16        ;
    MOV BP,DX        ;
    ADD BP,16        ;
    MOV AH,0CH       ;
    MOV AL,COLOR     ;
    MOV BH,0         ;
    LEA SI,HZBUF     ;
NEXT2:
    MOV BX,[SI]      ;
    XCHG BH,BL
NEXT1:
    ROL BX,1         ;
    PUSH BX          ;
    AND BX,1         ;
    CMP BX,0         ;
    JZ NEXT          ;
    INT 10H          ;
NEXT:
    INC CX           ;
    POP BX           ;
    CMP CX,DI        ;
    JB NEXT1         ;
    SUB CX,16        ;
    INC DX           ;
    INC SI           ;
    INC SI           ;
    CMP DX,BP        ;
    JB  NEXT2        ;
    LEA SI,XPOINTER  ;
    MOV AX,[SI]      ;
    ADD AX,16        ;
    MOV [SI],AX      ;
    POP BP           ;
    POP DI           ;
    POP SI           ;
    POP DX           ;
    POP CX           ;
    POP BX           ;
    POP AX           ;
    POP SI
    INC SI
    INC SI
INIT3:
    LEA BX,INIT1
    JMP BX
EXIT:
    pop si
    LEA SI,HZKHD
    MOV BX,[SI]
    MOV AH,3EH
    INT 21H
    POP ES
    POP DS
    POP BP
    POP DI
    POP SI
    POP DX
    POP CX
    POP BX
    POP AX
ENDM
START:
    MOV AX,DATA
    MOV DS,AX

    HZ 0,0"你",02H

    MOV AH,01H
    INT 16H

    MOV AH,4CH
    INT 21H

CODE ENDS
    END START