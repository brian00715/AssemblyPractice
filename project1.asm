include showImg.asm
DATA SEGMENT
    EQUAL_STR DB "===================================",0DH,0AH,'$'
    MENU_TIP DB "Press an alphabet to select a function0A0D$"
    TIPS1 DB "Press D to show date",'0A','0D','$'
    TIPS2 DB "P"
    DATE DB "DATE:",4 DUP(0),"/",2 DUP(0),"/",2 DUP(0)," ",3 DUP(0)," ",'$';,0DH,0AH,'$'
    WEEK DB "MON","TUS","WED","THS","TRI","SAT","SUN" ;星期预定义
    TIME DB 2 DUP(0),':',2 DUP(0),':',2 DUP(0)," ",'$';,0DH,0AH,'$'
    LINE_BREAK DB 0AH,0DH,'$'
    authorInfo DB "(C) COPYRIGHT SimonKenneth 2020",'$'
    BUFFER DB 100 DUP(0) ;通用缓冲区
    ;--------------------读取图片所需变量--------------------
;     bmpfname db '1.bmp', 0      ; 图片路径  
;     x0 dw 0  	                ; 当前显示界面的横坐标，初始为0
;     y0 dw 0            	        ; 当前显示界面的纵坐标，初始为0
;     handle dw ?                 ; 文件指针  
;     bmpdata1 db 256*4 dup(?)    ; 存放位图文件调色板  
;     bmpdata2 db 64000 dup(0)    ; 存放位图信息,64k  
;     bmpwidth dw ?               ; 位图宽度  
;     bmplength dw ?              ; 位图长度 
    
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

;==============================主过程==============================
BEGIN:       
        ;显示图片
        call openf   
        call readf  
        call proc1 
        call proc2 

        MOV AX,0600H	;清屏
	MOV BH,07H
	MOV CX,0
	MOV DX,204FH
	INT 10H
        CALL GET_DATE
        CALL SHOW_DATE
        CALL GET_TIME
        CALL SHOW_TIME

        LEA DX,EQUAL_STR
        MOV AH,09H
        INT 21H
EXIT:
        MOV AH,4CH
        INT 21H

;========================子过程定义=========================
; -----------GET_TIME-----------
; 子程序名：GET_TIME
; 功能：获取时间，并填充TIME数组
; 所用寄存器：ch,cl,dh中分别存放时分秒
; 入口参数：无
; 出口参数：无
GET_TIME PROC
        PUSH AX
        PUSH BX
        MOV AH,2CH      ;获取系统时间
        INT 21H
        XOR AX,AX       ;转换小时为ASC2
        MOV AL,CH
        LEA BX,TIME+1
        CALL NUM2ASC
        ADD BX,5

        MOV AL,CL
        CALL NUM2ASC
        ADD BX,5

        MOV AL,DH
        CALL NUM2ASC
        POP BX
        POP AX
        RET
GET_TIME ENDP

; 子程序名：SHOW_TIME
; 功能：显示日期
; 所用寄存器：
; 入口参数：AL,AH分别存X和Y坐标
; 出口参数：无
SHOW_TIME PROC
        PUSH DX 
        PUSH AX
        LEA DX,TIME
        MOV AH,09H
        INT 21H
        CALL PRINT_LINE_BREAK
        POP AX
        POP DX
        RET
SHOW_TIME ENDP

; -----------GET_DATE-----------
; 子程序名：get_date
; 功能：获取日期，并填充给DATE数组
; 所用寄存器：CX,DH,DL,AL
; 入口参数：无
; 出口参数：无
GET_DATE PROC  
        PUSH AX
        PUSH CX
        PUSH DX
        MOV AH,2AH      ;取日期
        INT 21H
        PUSH AX         ;传参需要用到AX，而AL又存储着星期

        MOV AX,CX       ;转换年
        MOV BX,OFFSET DATE+4+4
        CALL NUM2ASC    
        ADD BX,4+1+2

        MOV AX,DX
        MOV CL,8
        SHR AX,CL       ;转换月 
        CALL NUM2ASC
        ADD BX,2+1+2

        MOV AX,DX       ;转换日
        AND AX,00FFH    ;屏蔽AH
        TEST AL,0F0H    ;如果高4位是0，说明日没有十位，则手动补零以增强显示效果
        JZ ZERO
        JMP TRANS
ZERO:   MOV [BX-1],'0'
TRANS:  CALL NUM2ASC
        ADD BX,2+1+1    ;指向星期的开头，而不是末尾故是2+1+1不是2+1+3

        POP AX          ;取回星期
        AND AX,00FFH    ;屏蔽AH
        ;获取WEEK数组的偏移量以取得正确的星期字符，偏移量=（星期数-1）*3
        MOV DL,AL       ;作为乘数
        DEC DL          ;星期一的偏移量应为0
        MOV AL,3
        MUL DL          ;乘积送AX
        LEA SI,WEEK
        ADD SI,AX       ;加上偏移量
        MOV CX,3        ;给DATE存入星期字符
STORE:  MOV AL,[SI]
        MOV [BX],AL
        INC BX
        INC SI
        LOOP STORE
        POP DX
        POP CX
        POP AX
        RET
GET_DATE ENDP

; -----------SHOW_DATE-----------<TODO>
; 子程序名：SHOW_DATE
; 功能：显示日期
; 所用寄存器：DX,AH
; 入口参数：AL,AH分别存X和Y坐标
; 出口参数：无
SHOW_DATE PROC
        PUSH DX
        PUSH AX
        LEA DX,DATE
        MOV AH,09H  
        INT 21H
        CALL PRINT_LINE_BREAK
        POP AX
        POP DX
        RET
SHOW_DATE ENDP

; -----------NUM2ASC-----------
; 子程序名：NUM2ASC
; 功能：将数字转为ASC2码形式
; 所用寄存器：BX,AX
; 入口参数：AX存待转换数字，BX存字符串末尾
; 出口参数：BX指向字符串末尾的下一个位置
NUM2ASC PROC
        PUSH DX
        MOV SI,10
NEXT:   XOR DX,DX
        DIV SI          ; 从最高位开始逐位转换
        ADD DX,'0'
        MOV [BX],DL     ;转换结果存入字符串中
        DEC BX          ;指向下一个位置(由于从最高位开始转换，因此需要让指针减量，以实现高位存高地址)
        OR AX,AX        ;检查ZF,是否还有位需要转换
        JNZ NEXT
        POP DX
        RET
NUM2ASC ENDP

; -----------PRINT_LINE_BREAK-----------
; 子程序名：PRINT_LINE_BREAK
; 功能：打印一个换行符
PRINT_LINE_BREAK PROC
        PUSH DX
        PUSH AX
        LEA DX,LINE_BREAK
        MOV AH,09H
        INT 21H
        POP AX
        POP DX
        RET
PRINT_LINE_BREAK ENDP
;====================子过程定义END============================
CODE ENDS
    END START