DATA SEGMENT
    welc db 20 dup(32),1,'WELCOME YOU!',7,13,10
    cnt equ $-welc 
DATA ENDS

STACK SEGMENT stack 'stack'
    stap db 256 dup(0)
    topp equ this word
    top dw 200h
STACK ENDS

CODE SEGMENT
    ASSUME CS:CODE,DS:DATA,SS:STACK
START:
    MOV AX,DATA
    MOV DS,AX
    mov ax,stack
    mov ss,ax
    mov sp,offset top
    mov si,offset welc
    mov cx,cnt
    next:mov dl,[si]
    mov ah,2
    int 21h
    inc si
    loop next
    MOV AH,4CH
    INT 21H
CODE ENDS
    END START


