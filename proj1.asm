DATA SEGMENT
    EQUAL_STR DB "===================================",0DH,0AH,'$'
    MENU_TIP DB "Press an alphabet to select a function",0DH,0AH,'$'
    TIPS1 DB "T:Show Time",0AH,0DH,'$'
    TIPS2 DB "D:Show Date",0AH,0DH,'$'
    TIPS4 DB "Q:Quit This Program",0AH,0DH,'$'
    TIPS5 DB "Enter X,Y:",0AH,0DH,'$'
    TIPSX DB 30 
    TIPSY DB 0
    LINE_BREAK DB 0AH,0DH,'$'
    authorInfo DB "(C) COPYRIGHT SimonKenneth 2020",'$'
    BUFFER DB 100 DUP(0) ;通用缓冲区
    ;--------------------显示日期时间所需变量--------------------
    DATE DB "DATE:",4 DUP(0),"/",2 DUP(0),"/",2 DUP(0)," ",3 DUP(0)," ",'$';,0DH,0AH,'$'
    WEEK DB "MON","TUS","WED","THS","FRI","SAT","SUN" ;星期预定义
    TIME DB 2 DUP('0'),':',2 DUP('0'),':',2 DUP('0'),'$';,0DH,0AH,'$'
    DATE_X DB 20
    DATE_Y DB 20
    TIME_X DB 0
    TIME_Y DB 0
    ;--------------------显示图片所需变量--------------------
    bmpfname db '1.bmp', 0      ; 图片路径  
    x0 dw 0  	                ; 当前显示界面的横坐标，初始为0
    y0 dw 0            	        ; 当前显示界面的纵坐标，初始为0
    handle dw ?                 ; 文件指针  
    bmpdata1 db 256*4 dup(?)    ; 存放位图文件调色板  
    bmpdata2 db 64000 dup(0)    ; 存放位图信息,64k  
    bmpwidth dw ?               ; 位图宽度  
    bmplength dw ?              ; 位图长度 
    ;--------------------8253中断定时器所需变量--------------------
    count100 DB 100             ; 分频系数
    tenHour db '0'                ; 小时的十位
    hour db '0',':'
    tenMin db '0'
    minute db '0',':'
    tenSec db '0'
    second db '0'
    timer_x db 10
    timer_y db 10
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
;=====================宏定义END=======================
START:
        ;设定段寄存器
        MOV AX,DATA
        MOV DS,AX
        MOV ES,AX

;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>主过程<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
BEGIN:     
        CALL CLR_SRC
        ;设置光标位置
        SET_SHOW_POS 0,0
        
        CALL OPEN_PHOTO ;从硬盘读取图片 
        CALL READ_PHOTO
        CALL SET_COLOR 
        CALL SHOW_IMG   ;显示图片
        CALL SHOW_TIPS  ;显示提示信息
        CALL TIMER_INIT ;定时器初始化
        CALL TIMER_NABLE;定时器使能
        XOR CX,CX

MAIN_LOOP:              ;主循环
        CALL GET_TIME   ;时刻更新时间
        MOV AH,00H      ;等待键盘输入
        INT 16H
        CMP AL,'t'
        JE PRESS_T
        CMP AL,'d'
        JE PRESS_D
        CMP AL,'q'
        JE PRESS_Q
        CMP AX,4b00h
        JE MOVEL
        CMP AX,4D00H
        JE MOVER
        JMP MAIN_LOOP
MOVEL:  
        MOV AL,TIME_Y
        SUB AL,5
        MOV TIME_Y,AL
        JMP MAIN_LOOP
MOVER:
        MOV AL,TIME_Y
        ADD AL,5
        MOV TIME_Y,AL
        JMP MAIN_LOOP
PRESS_D:
        CALL GET_DATE
        CALL SHOW_DATE
        JMP MAIN_LOOP
PRESS_T:
        CALL SHOW_IMG
        CALL SHOW_TIME
        JMP MAIN_LOOP
PRESS_Q:
        JMP EXIT_MAIN
        
EXIT_MAIN:
        MOV AH,0        ;等待键盘输入后退出
        INT 16H
        mov ax, 3  	;返回80x25x16窗口
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
        SHOW_STR EQUAL_STR,0,0
        SHOW_STR MENU_TIP,1,0
        SHOW_STR TIPS1,2,0
        SHOW_STR TIPS2,3,0
        SHOW_STR TIPS4,4,0
        SHOW_STR EQUAL_STR,5,0
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
GET_TIME PROC FAR
        PUSH AX
        PUSH BX
        PUSH DX
        MOV AH,2CH      ;获取系统时间
        INT 21H
        XOR AX,AX   
        CALL CLR_TIME    
        ;转换小时为ASC2
        MOV AL,CH
        LEA BX,TIME+1
        CALL NUM2ASC
        ADD BX,5
        ;转换分
        MOV AL,CL
        CALL NUM2ASC
        ADD BX,5
        ;转换秒
        MOV AL,DH
        CALL NUM2ASC
        POP DX
        POP BX
        POP AX
        RET
GET_TIME ENDP

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
        SET_SHOW_POS TIME_X, TIME_Y     ;设置显示位置
        SHOW_STR TIME
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
ZERO:   
        MOV AX,'0'
        MOV [BX-1],AX
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
OPEN_PHOTO proc near  
    lea dx, bmpfname           
    mov ah, 3dh  
    mov al, 0  
    int 21h  	
    mov handle, ax  
    ret  
OPEN_PHOTO endp  

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
       ; 设置256色,320*200像素    640*480
       mov ax, 0013h  
       int 10h   
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
       out dx, al  
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
        cmp dx, 320
        jae l6  
        push dx  
        add dx, x0  
        cmp dx, bmpwidth  
        pop dx  
        jb  l5  
l6:     pop di  
        add di, 320   
        push cx  
        sub cx, y0  
        cmp cx, 200
        pop cx  
        jae l7    
        cmp cx, bmplength  
        jb  l2 
;当图片尺寸大于320*200时，移动方向键上下左右可以实现平移图片  
l7:
        jmp exit
        ; mov ah,0  			;键盘输入buffer
;         int 16h  
;         cmp ax, 4800h  			;up
;         je  up  
;         cmp ax, 5000h			;down  
;         je  down 
;         cmp ax, 4b00h			;left  
;         je  left  
;         cmp ax, 4d00h			;right  
;         je  right   
;         cmp ax, 011bh			;按esc退出  
;         je  exit  
;         jmp l7   
; up:  	mov ax, y0  
;         sub ax, 20 
;         jl  l7  
;         mov y0, ax  
;         jmp l1  
; down:   mov ax, y0  
;         add ax, 20
;         push ax  
;         add ax, 200  
;         cmp ax, bmplength  
;         pop ax  
;         jae l7  
;         mov y0,ax  
;         jmp l1  
; left:   mov ax, x0  
;         sub ax, 20 
;         jl  l7  
;         mov x0, ax  
;         jmp l1
; right:  mov ax, x0  
;         add ax, 20
;         push ax  
;         add ax, 320 
;         cmp ax, bmpwidth  
;         pop ax  
;         jae l7 
;         mov x0, ax  
;         jmp l1                       
exit:   
        ; mov ax, 3  		;返回80x25x16窗口
        ; int 10h
        RET      
SHOW_IMG endp 

; -----------TIMER_INIT-----------
; 子程序名：TIMER_INIT
; 功能: 初始化8253中断定时器
TIMER_INIT PROC
        PUSH BX
        PUSH AX
        ;将timer中断程序放入终端地址表08h的位置中
        CLI 
        MOV AX,0
        MOV ES,AX
        MOV DI,20H
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

; -----------TIMER_NABLE-----------
; 子程序名：TIMER_NABLE
; 功能: 使能定时中断和按键中断
TIMER_NABLE PROC
        MOV AL,0FCH
        OUT 21H,AL      ;写中断掩码寄存器
        STI             ;使能8086中断
        RET
TIMER_NABLE ENDP

; -----------TIMER-----------
; 子程序名：TIMER
; 功能: 定时器中断服务程序
TIMER PROC FAR
        PUSH AX
        CALL GET_TIME           ;更新时间
        DEC count100
        JNZ TIMERX

        MOV count100,100        ;计数溢出后重置计数器
        ADD TIME_X,1
        ADD TIME_Y,1
        CALL SHOW_IMG
        CALL SHOW_TIME
        ; SET_SHOW_POS timer_x,timer_y
        ; CALL DISP_CLK

        INC second              ;每计100次是1秒
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
        POP AX
        IRET            ;中断返回
TIMER ENDP

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