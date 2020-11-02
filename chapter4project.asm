DATA SEGMENT
    EQUAL_STR DB "===================================0A0D$"
    MENU_TIP DB "Press an alphabet to select a function0A0D$"
    TIPS1 DB "Press D to show date",'0A','0D','$'
    TIPS2 DB "P"
DATA END

STACK SEGMENT
    TOP LABEL WORD
STACK END

CODE SEGMENT 
    ASSUME DS:DATA,SS:STACK,CS:CODE
START:
    ;设定段寄存器
    MOV AX,CODE
    MOV DS,AX
    MOV ES,AX
    MOV SP,TOP
    JMP BEGIN   ;跳转至正式开始处
;========================子过程定义=========================
GET_DATE PROC  
    MOV AH,2AH
    INT 21H
    ADD CX,30H
    ADD DH,30H
    ADD DL,30H
    MOV AL,30H
    
    MOV AH,05H  ;显示输出
    MOV DL,DL
    INT 21H
    
    RET
GET_DATE ENDP
;====================子过程定义END============================

;=======================正式开始==============================
BEGIN:
    LEA DX,EQUAL_STR
    MOV AH,09H
    INT 21H

    MOV AH,4CH
    INT 21H

CODE ENDS
    END START