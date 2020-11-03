DATAS SEGMENT
    org 0100h
    ZFDATA db -5,-1,1,-2,2,-3,3,-4,4,-5
    NEGNUM db 10 dup(?)
    NONGENUM db 10 dup(?)
DATAS ENDS

STACKS SEGMENT
    dw 32 dup(?)
STACKS ENDS

CODES SEGMENT
    ASSUME CS:CODES,DS:DATAS,SS:STACKS
START:
    MOV AX,DATAS
    MOV DS,AX
    mov si,offset ZFDATA
    mov di,offset NEGNUM
    mov cx,10
L1: 
    mov al,[si]
    test al,[si]
    jz L2
    mov [di],al
    inc di
L2:
    inc si
    mov [di+10],al
    inc di
    loop L1
    
CODES ENDS
    END START

