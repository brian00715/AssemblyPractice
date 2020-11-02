DATA SEGMENT
    EQUAL_STR DB "===================================",0AH,0DH,'$'
    MENU_TIP DB "Press an alphabet to select a function0A0D$"
    TIPS1 DB "Press D to show date",'0A','0D','$'
    TIPS2 DB "P"
    DATE DB "DATE:",4 DUP(0),"/",2 DUP(0),"/",2 DUP(0)," ",0AH,0DH,'$'
    WEEK DB "MON","TUS","WED","THS","TRI","SAT","SUN" ;星期预定义
    BUFFER DB 100 DUP(0)
DATA ENDS

STACK SEGMENT STACK 'STACK'
    DB 256 DUP(0)
STACK ENDS

CODE SEGMENT 'CODE'
    ASSUME DS:DATA,SS:STACK,CS:CODE
START:
        ;设定段寄存器
        MOV AX,DATA
        MOV DS,AX
        MOV ES,AX

;=======================主过程==============================
BEGIN:
        CALL GET_DATE
        LEA BX,BUFFER
        MOV AX,2020
        CALL NUM2ASC
        LEA DX,EQUAL_STR
        MOV AH,09H
        INT 21H

        MOV AH,4CH
        INT 21H

;========================子过程定义=========================
; -----------GET_DATE-----------
; 子程序名：get_date
; 功能：获取日期，并填充给DATE和WEEK数组
; 所用寄存器：CX,DH,DL,AL
; 入口参数：无
; 出口参数：无
GET_DATE PROC  
        MOV AH,2AH ;取日期
        INT 21H
        ADD CX,30H ;年份
        ADD DH,30H ;月份
        ADD DL,30H ;日
        MOV AL,30H ;星期
        LEA BX,DATE
    COPY:
        MOV BX[5],CX
        MOV BX[10],DX
        MOV BX[14],AL
        MOV BX[15],BYTE PTR 0AH
        MOV BX[16],BYTE PTR 0DH
        MOV BX[17],BYTE PTR '$'
        ;显示日期
        LEA DX,DATE
        MOV AH,09H  
        INT 21H
        RET
GET_DATE ENDP

; -----------NUM2ASC-----------
; 子程序名：NUM2ASC
; 功能：将数字转为ASC2码形式
; 所用寄存器：BX,AX
; 入口参数：AX存待转换数字，BX存字符串基址
; 出口参数：无
NUM2ASC PROC
        MOV SI,10
NEXT:   XOR DX,DX
        DIV SI      ; 从最高位开始逐位转换
        ADD DX,'0'
        MOV [BX],DL ;转换结果存入字符串中
        DEC BX      ;指向下一个位置
        OR AX,AX    ;检查ZF,是否还有位需要转换
        JNZ NEXT
        RET
NUM2ASC ENDP

;====================子过程定义END============================
CODE ENDS
    END START