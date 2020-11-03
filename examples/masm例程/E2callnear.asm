DATAS SEGMENT
       buffer dw  0, 1, -5, 10, 256, -128, -100, 45, 6
              dw  3, -15, -67, 39, 4, 20, -1668,-32766
              dw  32765, -525, 300
       count  dw  20  
       max    dw  ?
DATAS ENDS

STACKS SEGMENT stack 'stack'
    stap db 256 dup(?)
STACKS ENDS

CODES SEGMENT
    ASSUME CS:CODES,DS:DATAS,SS:STACKS
START:
    MOV AX,DATAS
    MOV DS,AX
    ;此处输入代码段代码
    MOV AH,4CH
    INT 21H
CODES ENDS
    END START

