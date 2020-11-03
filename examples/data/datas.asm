DATAS SEGMENT
    org db 10,-5,30,-60,0,18,-7,3,12,-8  
DATAS ENDS

STACKS SEGMENT stack
    dw 20 dup(?)
STACKS ENDS

CODES SEGMENT'code'
    ASSUME CS:CODES,DS:DATAS,SS:STACKS
START:
    MOV AX,DATAS
    MOV DS,AX
    mov si,offset datas
    mov di,0200h
    mov cx,10
L1:
    mov al,[si]
    inc si
    test al,80h
    jz L2
    mov [di],al
    inc di
L2:
    loop L1
    MOV AH,4CH
    INT 21H
CODES ENDS
    END START
