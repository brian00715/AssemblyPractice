;--------------------------------------------------------------------------
; Author: SimonKenneth                                                    ;
; Date  : 2020/11/14                                                      ;
; ID    : 2018211739                                                      ;
;--------------------------------------------------------------------------

DATA SEGMENT
    ;--------------------显示菜单--------------------
    EQUAL_STR DB "========================",'$'
    MENU_TIP DB "Press an alphabet to select a function",'$'
    TIPS1 DB     10H," T:Show Time          ",11H,'$'
    TIPS2 DB     10H," D:Show Date          ",11H,'$'
    TIPS3 DB     10H," C:Start The Timer    ",11H,'$'
    TIPS4 DB     10H," S:Stop The Timer     ",11H,'$'
    TIPS5 DB     10H," R:Restart The Timer  ",11H,'$'
    TIPS6 DB     10H," X:Surprise!          ",11H,'$'    
    TIPS7 DB     10H," Q:Quit This Program  ",11H,'$'
    LINE_BREAK DB 0AH,0DH,'$'
    authorInfo DB "Copyright (C) 2020 Simon",'$'
    colorIndex DB 00H
    colorHigh DB 00H
    colorLow DB 09H
    BUFFER DB 100 DUP(0)        ;通用缓冲区
    ;--------------------显示日期时间所需变量--------------------
    DATE DB "Date:0000/00/00 000",'$','$'
    WEEK DB "MON","TUS","WED","THS","FRI","SAT","SUN" ;星期预定义
    TIME DB "00:00:00",'$','$'
    DATE_X DB 20                ;图形模式下x坐标范围0~49,y坐标范围0~39 
    DATE_Y DB 20
    TIME_X DB 0
    TIME_Y DB 0
    showDate_Flag DB 0
    ;--------------------显示图片所需变量--------------------
    bmpfname db '1.bmp',0       ; 图片路径  
    backGround db 'bg.bmp',0
    x0 dw 0  	                ; 当前显示界面的横坐标，初始为0
    y0 dw 0            	        ; 当前显示界面的纵坐标，初始为0
    handle dw ?                 ; 文件指针  
    bmpdata1 db 256*4 dup(?)    ; 存放位图文件调色板  
    bmpdata2 db 61000 dup(0)    ; 存放位图信息,64k  
    bmpwidth dw ?               ; 位图宽度  
    bmplength dw ?              ; 位图长度 
    ;--------------------8253中断定时器所需变量--------------------
    count100 DB 100             ; 分频系数
    tenHour db '0'              ; 小时的十位
    hour db '0',':'
    tenMin db '0'
    minute db '0',':'
    tenSec db '0'
    second db '0'
    timerStr db "00:00:00:0",'$'
    secUpdate db 0
    timerStart_Flag db 0
    timerStop_Flag db 0
    ;--------------------绘制图形所需变量--------------------
    gameMode db 0
;     ball db 0,0,0,1,1,1,1,0,0,0
;          db 0,1,1,1,1,1,1,1,1,0 
;          db 0,1,1,1,1,1,1,1,1,0 
;          db 1,1,1,1,1,1,1,1,1,1 
;          db 1,1,1,1,1,1,1,1,1,1 
;          db 1,1,1,1,1,1,1,1,1,1 
;          db 1,1,1,1,1,1,1,1,1,1 
;          db 0,1,1,1,1,1,1,1,1,0 
;          db 0,1,1,1,1,1,1,1,1,0 
;          db 0,0,0,1,1,1,1,0,0,0
DATA ENDS

STACK SEGMENT STACK 'STACK'
    DB 256 DUP(0)
STACK ENDS

CODE SEGMENT 'CODE'
    ASSUME DS:DATA,SS:STACK,CS:CODE
;=====================宏定义=======================
SET_SHOW_POS MACRO POS_X,POS_Y
        MOV BH,0       ;页码
        mov DH,POS_X   ;行
        mov DL,POS_Y   ;列
        mov ah,02H      
        int 10h
        ENDM
SHOW_STR MACRO STRING_NAME,STR_X,STR_Y
        SET_SHOW_POS STR_X,STR_Y
        LEA DX,STRING_NAME
        MOV AH,09H
        INT 21h
        ENDM
SHOW_COLOR_CHAR MACRO CHAR,CHX,CHY,COLOR,TIMES
        SET_SHOW_POS CHX,CHY
        MOV CX,TIMES
        MOV AH,09H
        MOV AL,CHAR
        MOV BL,COLOR
        INT 10H
        ENDM
;=====================宏定义END=======================
START:
        ;设定段寄存器
        MOV AX,DATA
        MOV DS,AX
        MOV ES,AX

;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>主过程<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
BEGIN:            
        CALL CLR_TIMER_STR
        CALL CLR_SRC
        LEA DX, bmpfname
        CALL OPEN_PHOTO                 ;从硬盘读取图片 
        CALL READ_PHOTO
        CALL SET_COLOR 
        CALL SHOW_IMG                   ;显示图片
        CALL SHOW_TIPS                  ;显示提示信息
;------------------主循环------------------
MAIN_LOOP:                              
        MOV AH,01H                      ;键盘输入,不等待
        INT 16H     
        JNZ SCAN_BUTTON

        SHOW_COLOR_CHAR '=',0,8,colorIndex,24
        MOV AL,colorIndex
        ADD AL,30H

        SHOW_COLOR_CHAR AL,0,0,09H,1

        CMP gameMode,1
        JE gameLoop
        SHOW_STR TIME,9,16

        CMP timerStop_Flag,1
        JE NEXT1
        SHOW_STR timerStr,11,15

        NEXT1:
                CMP secUpdate,1                 ;8253的秒位发生变化
                JAE SEC_PASSED
                CMP timerStart_Flag,1           ;启动8253定时器
                JE TIMER_START
                CALL GET_TIME
        TIMER_START:
                CALL UPDATE_TIMER_STR
                JMP MAIN_LOOP
        SEC_PASSED:
                MOV secUpdate,0
                CALL GET_TIME_FROM_CLK
                JMP MAIN_LOOP
        gameLoop:
                CALL SHOW_IMG
                JMP MAIN_LOOP
        SCAN_BUTTON:
                MOV AH,00H
                INT 16H                 ;将缓冲区的字符读走，使缓冲区清空
                CMP AL,'t'
                JE PRESS_T
                CMP AL,'d'
                JE PRESS_D
                CMP AL,'q'
                JE PRESS_Q
                CMP AX,4b00h            ;左方向键
                JE MOVEL
                CMP AX,4D00H            ;右方向键
                JE MOVER
                CMP AL,'c'
                JE PRESS_C
                CMP AL,'s'
                JE PRESS_S
                CMP AL,'r'
                JE PRESS_R
                CMP AL,'x'
                JE PRESS_X
                JMP MAIN_LOOP
        MOVEL:  
                SUB TIME_X,5
                INC colorHigh
                MOV AL,colorLow
                OR AL,colorHigh
                MOV colorIndex,AL
                JMP MAIN_LOOP
        MOVER:
                ADD TIME_Y,5
                JMP MAIN_LOOP
        PRESS_D:
                CALL GET_DATE
                MOV showDate_Flag,1
                SHOW_STR DATE,13,10
                JMP MAIN_LOOP
        PRESS_T:
                CALL GET_TIME            ;更新时间
                CALL SHOW_TIME
                JMP MAIN_LOOP
        PRESS_C:
                MOV timerStart_Flag,1
                MOV timerStop_Flag,0
                CALL CLR_TIMER
                CALL CLR_TIMER_STR
                CALL TIMER_INIT          ;定时器初始化
                CALL TIMER_ENABLE        ;定时器使能
                JMP MAIN_LOOP
        PRESS_S:        
                MOV timerStop_Flag,1
                JMP MAIN_LOOP
        PRESS_R:
                CALL CLR_TIMER_STR
                CALL CLR_TIMER
                SHOW_STR timerStr,11,15
                JMP MAIN_LOOP
        PRESS_X:
                CALL CLR_SRC
                LEA DX,backGround
                CALL OPEN_PHOTO
                CALL READ_PHOTO
                CALL SHOW_IMG
                MOV gameMode,1
                JMP MAIN_LOOP
        PRESS_Q:
                JMP EXIT_MAIN
;------------------主循环END------------------
EXIT_MAIN:
        ; MOV AH,0                        ;等待键盘输入后退出
        ; INT 16H
        mov ax, 3  	                ;返回80x25x16窗口
        int 10h
        MOV AH,4CH
        INT 21H

;========================子过程定义=========================
; -----------CLR_SRC-----------
; 子程序名：CLR_SRC
; 功能：清屏
CLR_SRC PROC
        PUSH AX
        PUSH BX
        PUSH CX
        PUSH DX
        MOV AX,0600H	
	MOV BH,07H
	MOV CX,0
	MOV DX,204FH
	INT 10H
        POP DX
        POP CX
        POP BX
        POP AX
        RET
CLR_SRC ENDP

; -----------SHOW_TIPS-----------
; 子程序名：SHOW_TIPS
; 功能：显示提示信息
SHOW_TIPS PROC        
        PUSH AX
        PUSH DX
        SHOW_COLOR_CHAR '=',0,8,03H,24
        ; SHOW_STR EQUAL_STR,0,8
        SHOW_STR TIPS1,1,8
        SHOW_STR TIPS2,2,8
        SHOW_STR TIPS3,3,8
        SHOW_STR TIPS4,4,8
        SHOW_STR TIPS5,5,8
        SHOW_STR TIPS6,6,8
        SHOW_COLOR_CHAR '=',7,8,08H,24
        ; SHOW_STR EQUAL_STR,7,8
        SHOW_STR authorInfo,49,0
        POP DX
        POP AX
        RET
SHOW_TIPS ENDP

; -----------GET_TIME-----------
; 子程序名：GET_TIME
; 功能：获取时间，并填充TIME数组
; 所用寄存器：ch,cl,dh中分别存放时分秒
; 入口参数：无
; 出口参数：无
GET_TIME PROC
        PUSH AX
        PUSH BX
        PUSH DX
        MOV AH,2CH      ;获取系统时间
        INT 21H
        XOR AX,AX   
        CALL CLR_TIME 
        ; 00:00:00   
        ;转换小时为ASC2
        MOV AL,CH
        LEA BX,TIME+1
        CALL NUM2ASC
        LEA BX,TIME+4
        ;转换分
        MOV AL,CL
        CALL NUM2ASC
        LEA BX,TIME+7
        ;转换秒
        MOV AL,DH
        CALL NUM2ASC
        ADD BX,3
        POP DX
        POP BX
        POP AX
        RET
GET_TIME ENDP

; -----------GET_TIME_FROM_CLK-----------
; 子程序名：GET_TIME_FROM_CLK
; 功能：从定时器继续当前时钟
; note:由于定时中断服务程序占用了中断向量表中08H的位置，导致
;       INT21H中获取系统时间的功能无法继续使用，故需要此辅助
;       函数继续更新时间
GET_TIME_FROM_CLK PROC FAR
        ;00:00:00
        PUSH AX
        PUSH BX
        LEA BX,TIME
        INC BYTE PTR[BX+7]      ;秒个位
        MOV AL,[BX+7]
        CMP AL,'9'
        JLE RET1
        MOV BYTE PTR[BX+7],'0'
        INC BYTE PTR[BX+6]      ;秒十位
        MOV AL,[BX+6]
        CMP AL,'5'
        JLE RET1
        MOV BYTE PTR[BX+6],'0'
        INC BYTE PTR[BX+4]      ;分个位
        MOV AL,[BX+4]
        CMP AL,'9'
        JLE RET1
        MOV BYTE PTR[BX+4],'0'
        INC BYTE PTR[BX+3]      ;分十位
        MOV AL,[BX+3]
        CMP AL,'5'
        JLE RET1
        MOV BYTE PTR[BX+3],'0'
        INC BYTE PTR[BX+1]      ;时个位
        MOV AL,[BX+1]
        CMP AL,'3'
        JLE RET1
        MOV BYTE PTR[BX+1],'0'
        INC BYTE PTR[BX]      ;时十位
        MOV AL,[BX]
        CMP AL,'2'
        JLE RET1
        MOV BYTE PTR[BX],'0' 
RET1:   
        POP BX
        POP AX
        RET
GET_TIME_FROM_CLK ENDP

; -----------CLR_TIME-----------
; 子程序名：CLR_TIME
; 功能：清空TIME数组
CLR_TIME PROC FAR
        PUSH BX
        MOV BX,OFFSET TIME
        MOV BYTE PTR[BX],'0'
        MOV BYTE PTR[BX+1],'0'
        MOV BYTE PTR[BX+2],':'
        MOV BYTE PTR[BX+3],'0'
        MOV BYTE PTR[BX+4],'0'
        MOV BYTE PTR[BX+5],':'
        MOV BYTE PTR[BX+6],'0'
        MOV BYTE PTR[BX+7],'0'
        POP BX
        RET
CLR_TIME ENDP

; 子程序名：SHOW_TIME
; 功能：显示日期
; 所用寄存器：
; 入口参数：
; 出口参数：无
SHOW_TIME PROC
        PUSH DX 
        PUSH AX
        SHOW_STR TIME,TIME_X,TIME_Y
        ; CALL PRINT_LINE_BREAK
        POP AX
        POP DX
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
        ;DATE:xxxx/xx/xx xxx
        MOV AH,2AH      ;取日期
        INT 21H
        PUSH AX         ;传参需要用到AX，而AL又存储着星期

        MOV AX,CX       ;转换年
        MOV BX,OFFSET DATE+4+4
        CALL NUM2ASC    
        
        LEA BX,DATE+11
        MOV AX,DX
        MOV CL,8
        SHR AX,CL       ;转换月 
        CALL NUM2ASC

        LEA BX,DATE+14
        MOV AX,DX       ;转换日
        AND AX,00FFH    ;屏蔽AH
        CALL NUM2ASC
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

; -----------SHOW_DATE-----------
; 子程序名：SHOW_DATE
; 功能：显示日期
; 所用寄存器：DX,AH
; 入口参数：
; 出口参数：无
SHOW_DATE PROC
        PUSH DX
        PUSH AX
        SET_SHOW_POS DATE_X,DATE_Y
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

; -----------OPEN_PHOTO-----------
; 子程序名：OPEN_PHOTO
; 功能: 打开图片文件
; 入口参数：DX存图片路径名
OPEN_PHOTO PROC NEAR  
;     LEA DX, bmpfname           
    MOV AH, 3DH  
    MOV AL, 0  
    INT 21h  	
    MOV handle, AX  
    RET  
OPEN_PHOTO ENDP  

; -----------READ_PHOTO-----------
; 子程序名：READ_PHOTO
; 功能: 读取图片文件，获取位图信息函数  
READ_PHOTO proc near  
        ; 移动文件指针,bx = 文件代号， cx:dx = 位移量， al = 0 即从文件头绝对位移  
        mov ah, 42h  
        mov al, 0  
        mov bx, handle  
        mov cx, 0  
        mov dx, 12h             ; 跳过18个字节直接指向位图的宽度信息  
        int 21h  
        ; 读取文件，ds:dx = 数据缓冲区地址, bx = 文件代号, cx = 读取的字节数, ax = 0表示已到文件尾  
        mov ah, 3fh  
        lea dx, bmpwidth        ; 存放位图宽度信息  
        mov cx, 2  
        int 21h  
        ;操作同上，获取位图长度信息
        mov ah, 42h  
        mov al, 0  
        mov bx, handle  
        mov cx, 0  
        mov dx, 16h             ; 跳过22个字节直接指向位图的长度信息  
        int 21h  
        mov ah, 3fh  
        lea dx, bmplength       ; 存放位图长度信息  
        mov cx, 2  
        int 21h                          
	; 读取位图颜色信息    
        ; 跳过前54个字节进入颜色信息  
        mov ah, 42h  
        mov al, 0  
        mov bx, handle  
        mov cx, 0  
        mov dx, 36h     
        int 21h  
        mov ah, 3fh  
        lea dx, bmpdata1        ; 将颜色信息放入bmpdata1  
        mov cx, 256*4           ; 蓝+绿+红+色彩保留（0）一共占256*4个字节  
        int 21h  
        ret  
READ_PHOTO endp  

; -----------SET_COLOR-----------
; 子程序名：SET_COLOR
; 功能: 设置调色板输出色彩索引号及rgb数据共写256次   
SET_COLOR proc near  
        ;设置256色,320*200像素  640*480
       mov ax, 0013h  
       int 10h   
        ; MOV AX,4F02H
        ; MOV BX,103H
        ; INT 10H
       mov cx, 256  
       lea si, bmpdata1         ; 颜色信息  
l0:    mov dx, 3c8h             ; 设定i/o端口  
       mov ax, cx  
       dec ax  
       neg ax                   ; 求补  
       add ax, 255              ; ax = ffffh(al = ffh, ah = ffh)  
       out dx, al               ; 将al中的数据传入dx指向的i/o端口中  
       inc dx  
       ; bmp调色板存放格式：bgrAlphabgrAlpha...(Alpha为空00h)  
       ; rgb/4后写入，显卡要求，rgb范围(0~63)，位图中(0~255)  
       mov al, [si+2]           ;r通道
       shr al, 1                
       shr al, 1  
       out dx, al  
       mov al, [si+1]  		;g通道	
       shr al, 1  
       shr al, 1  
       out dx, al  
       mov al, [si]  		;b通道
       shr al, 1  
       shr al, 1  
       OUT dx, al  
       add si, 4  
       loop l0  
       ret  
SET_COLOR endp  

; -----------SHOW_IMG-----------
; 子程序名：SHOW_IMG
; 功能: 显示图片
SHOW_IMG proc near  
        mov bx, 0a000h          ; 写屏 
        mov es, bx  
l1:  	xor di,di  
        cld                     ; df清零  
        mov cx, y0              ; cx = 0  
l2:  	mov ax, bmpwidth        ; ax = 位图宽度  
        mov dx, ax  
        and dx, 11b  	        ;位图宽度是否为4倍数
        jz  l3  
        mov ax, 4  
        sub ax, dx  
        add ax, bmpwidth  	;填充
l3:  	inc cx			;cx行数
        mul cx  				
        mov bx, 0  
        sub bx, ax  
        mov ax, bx  			
        mov bx, 0  
        sbb bx, dx  
        mov dx, bx  			
        push cx  
        mov cx, dx  
        mov dx, ax  
        mov bx, handle  
        mov ax, 4202h  		;向前移动cxdx个字节，无符号
        int 21h  
        lea dx, bmpdata2  
        mov cx, bmpwidth  
        mov ah, 3fh  
        int 21h  
        pop cx  
        cmp ax, bmpwidth  
        jb  l7  
        lea si, bmpdata2  
        add si, x0 
	push di  
        xor dx,dx   
l5:     lodsb  
        stosb  			;[si] -> [di],si++,di++
        inc dx  
        cmp dx, 320     ;320
        jae l6  
        push dx  
        add dx, x0  
        cmp dx, bmpwidth  
        pop dx  
        jb  l5  
l6:     pop di  
        add di, 320     ;320
        push cx  
        sub cx, y0  
        cmp cx, 200     ;200
        pop cx  
        jae l7    
        cmp cx, bmplength  
        jb  l2 
l7:
        jmp exit        
exit:   
        RET      
SHOW_IMG endp 

; -----------TIMER_INIT-----------
; 子程序名：TIMER_INIT
; 功能: 初始化8253中断定时器
TIMER_INIT PROC
        PUSH BX
        PUSH AX
        ;将timer中断程序放入中断地址表08h的位置中
        CLI 
        MOV AX,0
        MOV ES,AX
        MOV DI,20H      ;8*4=32=20h
        MOV AX,OFFSET TIMER
        STOSW
        MOV AX,CS
        STOSW
        ;定时器参数配制，使用通道0，每秒中断100次
        MOV AL,36H
        OUT 43H,AL
        MOV BX,11932
        MOV AL,BL
        OUT 40H,AL 
        MOV AL,BH
        OUT 40H,AL 

        POP AX
        POP BX
        RET
TIMER_INIT ENDP

; -----------TIMER_ENABLE-----------
; 子程序名：TIMER_ENABLE
; 功能: 使能定时中断
TIMER_ENABLE PROC
        MOV AL,0FCH
        OUT 21H,AL      ;写中断掩码寄存器
        STI             ;使能8086中断
        RET
TIMER_ENABLE ENDP

; -----------TIMER-----------
; 子程序名：TIMER
; 功能: 定时中断服务程序
TIMER PROC FAR
        PUSH AX
        PUSH BX
        DEC count100
        JNZ TIMERX
        MOV count100,100        ;1秒，计数溢出后重置计数器
        ADD secUpdate,1

        INC second
        CMP second,'9'
        JLE TIMERX
        MOV second,'0'
        INC tenSec
        CMP tenSec,'6'
        JL TIMERX
        MOV tenSec,'0'
        INC minute
        CMP minute,'9'
        JLE TIMERX
        MOV minute,'0'
        INC tenMin
        CMP tenMin,'6'
        JL TIMERX
        MOV tenMin,'0'
        INC hour
        CMP hour,'9'
        JA ADDHOUR
        CMP HOUR,'3'
        JNZ TIMERX
        CMP tenHour,'1'
        JNZ TIMERX
        MOV hour,'1'
        MOV tenHour,'0'
        JMP SHORT TIMERX
ADDHOUR:
        INC tenHour
        MOV hour,'0'
TIMERX:
        MOV AL,20H
        OUT 20H,AL

        POP BX
        POP AX
        IRET                    ;中断返回
TIMER ENDP

; -----------UPDATE_TIMER-----------
; 子程序名：UPDATE_TIMER
; 功能: 更新计时器显示字符串
UPDATE_TIMER_STR PROC
        PUSH AX
        PUSH BX
        PUSH DX
        ;00:00:00:0
        XOR AX,AX
        CMP timerStart_Flag,0
        JE EXIT_UPDATE_TIMER
        MOV AL,count100         
        MOV DX,10
        DIV DL                  ;AL存十位，AH存个位
        ADD AL,30H
        ; ADD AH,30H
        LEA BX,timerStr         ;获取偏移量
        MOV BYTE PTR[BX+9],AL
        ; MOV BYTE PTR[BX+10],AH
        MOV AL,tenHour
        MOV BYTE PTR[BX],AL
        MOV AL,hour
        MOV BYTE PTR[BX+1],AL
        MOV AL,tenMin
        MOV BYTE PTR[BX+3],AL
        MOV AL,minute
        MOV BYTE PTR[BX+4],AL
        MOV AL,tenSec
        MOV BYTE PTR[BX+6],AL
        MOV AL,second
        MOV BYTE PTR[BX+7],AL
EXIT_UPDATE_TIMER:
        POP DX 
        POP BX 
        POP AX
        RET
UPDATE_TIMER_STR ENDP

CLR_TIMER_STR PROC
        PUSH BX
        LEA BX,timerStr
        ;00:00:00:0
        MOV BYTE PTR [BX],'0'
        MOV BYTE PTR [BX+1],'0'
        MOV BYTE PTR [BX+3],'0'
        MOV BYTE PTR [BX+4],'0'
        MOV BYTE PTR [BX+6],'0'
        MOV BYTE PTR [BX+7],'0'
        MOV BYTE PTR [BX+9],'0'
        POP BX
        RET
CLR_TIMER_STR ENDP

CLR_TIMER PROC
        MOV second,'0'
        MOV tenSec,'0'
        MOV minute,'0'
        MOV tenMin,'0'
        MOV hour,'0'
        MOV tenHour,'0'
        RET
CLR_TIMER ENDP

; -----------DISP_CLK-----------
; 子程序名：DISP_CLK
; 功能: 显示定时器时间
DISP_CLK PROC
        PUSH BX
        PUSH AX
        MOV BX,OFFSET tenHour
        MOV CX,8
DISP_LOOP:
        MOV AL,[BX]     ;AL存待显示字符
        CALL DISP_CHAR
        INC BX
        LOOP DISP_LOOP
        POP AX
        POP BX
        RET 
DISP_CLK ENDP

; -----------DISP_CHAR-----------
; 子程序名：DISP_CHAR
; 功能: 显示一个字符
; 入口参数：AL存放待显示字符
DISP_CHAR PROC
        PUSH BX
        MOV BX,0
        MOV AH,14
        INT 10h
        POP BX
        RET
DISP_CHAR ENDP

;====================子过程定义END============================
CODE ENDS
    END START