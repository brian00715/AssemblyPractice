DATAS SEGMENT
	MENU DB 'Please input DATE<D> OR TIME<T> OR CLEAR<C> OR QUIT<Q> OR TIMER<P>',0AH,0DH,'INPUT:$'
	HOUR DB '0'
	MIN DB '0'
	SEC DB '0'
	YEAR DW ?
	MONTH DB ?
	DAY DB ?
	BUFF DB 8 DUP(?)
	MSG_DATE DB 0AH,0DH,'THE DATE OF TODAY IS:$'
	MSG_TIME DB 0AH,0DH,'THE TIME RIGHT NOW IS:$'
	HOU1 db '0'
	HOU2 db '0'
	MW1 db ':'
	MIN1 db '0'
	MIN2 db '0'
	MV2 db ':'
	SEC1 db '0'
	SEC2 db '0'
	MW3 db ':'
	MSEC1 db '0'
	MSEC2 db '0'
	COUNT equ $-HOU1
	H db 0
	TIMER_MSG DB "Please input START<S> OR PAUSE<P> OR CONTINUE<S> OR EXIT<ESC> OR ZERO<Z>",0AH,0DH
	COUNT_TIMER_MSG EQU $-TIMER_MSG
DATAS ENDS
CODES SEGMENT
	ASSUME CS:CODES,DS:DATAS
START:
	CALL HUICHE
	MOV ax,DATAS
	mov ds,ax
    CALL FUNCTION_MENU
    MOV AH,1H
    INT 21H
    CMP AL,43H;AL='C'?
	JZ CLEAR_SCREEN
	CMP AL,'c'
	JZ CLEAR_SCREEN
	CMP AL,44H;AL='D'?
	JZ DATE
	CMP AL,'d'
	JZ DATE
	CMP AL,54H;AL='T'?
	JZ TIME
	CMP AL,'t'	
	JZ TIME
	CMP AL,50H;AL='P'?
	JZ TIMER
	CMP AL,'p'
	JZ TIMER
	CMP AL,'q'
	JZ QUIT
	CMP AL,51H;AL='Q'?
	JZ QUIT
    JMP START
TIMER:
	CALL FUNCTION_TIMER
CLEAR_SCREEN:
	CALL FUNCTION_CLEAR_SCREEN
	JMP START
DATE:
	CALL FUNCTION_DATE
	JMP START
TIME:
	CALL FUNCTION_TIME
	JMP START
QUIT:
	CALL FUNCTION_QUIT
;提示语句
FUNCTION_MENU PROC NEAR
    MOV AH,09H
    MOV DX,OFFSET MENU
    INT 21H
;提示语句结束
	RET
FUNCTION_MENU ENDP

FUNCTION_CLEAR_SCREEN PROC NEAR
	MOV AH,0
	MOV AL,3
	MOV BL,0
	INT 10H
	RET
FUNCTION_CLEAR_SCREEN ENDP

FUNCTION_TIME PROC NEAR
	MOV DX,OFFSET MSG_TIME
	MOV AH,9
	INT 21H
	MOV AH,2CH
	INT 21H
	MOV HOUR,CH
	MOV MIN,CL
	MOV SEC,DH
	MOV DI,OFFSET BUFF
	MOV AL,HOUR
	MOV AH,0
	MOV CX,2
	CALL DIVNUM
	CALL LISNUM
	CALL DISPLAY_LIANJIEFU_MAOHAO
	MOV AL,MIN
	MOV AH,0
	MOV CX,2
	CALL DIVNUM
	CALL LISNUM
	CALL DISPLAY_LIANJIEFU_MAOHAO
	MOV AL,SEC
	MOV AH,0
	MOV CX,2
	CALL DIVNUM
	CALL LISNUM
	CALL HUICHE
	JMP START
	RET
FUNCTION_TIME ENDP

FUNCTION_DATE PROC NEAR
	MOV DX,OFFSET MSG_DATE
	MOV AH,9
	INT 21H
	MOV AH,2AH
	INT 21H
	MOV YEAR,CX
	MOV MONTH,DH
	MOV DAY,DL
	MOV DI,OFFSET BUFF
	MOV AX,YEAR
	MOV CX,4
	CALL DIVNUM
	CALL LISNUM
	CALL DISPLAY_LIANJIEFU_DUANHENGXIAN
	MOV AL,MONTH
	MOV AH,0
	MOV CL,2
	CALL DIVNUM
	CALL LISNUM
	CALL DISPLAY_LIANJIEFU_DUANHENGXIAN
	MOV AL,DAY
	MOV AH,0
	MOV CL,2
	CALL DIVNUM
	CALL LISNUM
	CALL HUICHE
	RET
FUNCTION_DATE ENDP

FUNCTION_QUIT PROC NEAR
	
	mov ah, 4ch
	int 21h
FUNCTION_QUIT ENDP


DIVNUM PROC NEAR ;二进制转BCD码
	PUSH CX
AGAIN:
	MOV BL,0AH
	DIV BL
	MOV [DI],AH
	MOV AH,0
	INC DI
	LOOP AGAIN
	DEC DI
	POP CX
	RET
DIVNUM ENDP

LISNUM PROC NEAR
LOP:
	MOV DL,[DI]
	ADD DL,30H
	MOV AH,2
	INT 21H
	PUSH CX
	MOV CX,1
	MOV BH,0
	MOV AH,3
	INT 10H
	INC DL
	MOV AH,2
	INT 10H
	POP CX
	DEC DI
	LOOP LOP
	INC DI
	RET
LISNUM ENDP

DISPLAY_LIANJIEFU_DUANHENGXIAN PROC NEAR
	MOV DL,'-'
	MOV AH,2H
	INT 21H
	RET
DISPLAY_LIANJIEFU_DUANHENGXIAN ENDP

DISPLAY_LIANJIEFU_MAOHAO PROC NEAR
	MOV DL,':'
	MOV AH,2H
	INT 21H
	RET
DISPLAY_LIANJIEFU_MAOHAO ENDP

HUICHE PROC NEAR
	PUSH DX
	PUSH AX
	MOV DL,0AH
	MOV AH,2H
	INT 21H
	MOV DL,0DH
	MOV AH,2H
	INT 21H
	POP AX
	POP DX
	RET
HUICHE ENDP

FUNCTION_TIMER PROC NEAR
start_timer:
	call clean_screen
	push ax
	push bx
	mov ax,0600H;ah=06(滚动)al=00(全屏空白)
	mov bh,000fH;设置背景颜色(3)和前景颜色(F)
	SUB CX,CX
	MOV DX,5F5FH
	INT 10H
	POP AX
	POP BX
	MOV DH,1; 行号
	MOV DL,0 ; 列号
	MOV BH,0 ; 页号
	MOV AH,2 ; 置光标位置
	INT 10H
	mov cx, count_timer_msg
	mov si, offset timer_msg
	show3:
	mov ah,0eh
	mov al,[si]
	int 10h
	inc si
	loop show3
	call locate_cursor
	call show
q2: 
	mov ah,08h ; 键盘输入无回显， al= 输入字符
	int 21h
	cmp al, 1bh ; 按下 Esc 键结束程序
	je START
	jmp yy
GOOUT1: 
	mov ah, 4ch
	int 21h
yy: 
	CMP AL,'Z'
	JE CLEAR
	CMP AL,'z'
	JE CLEAR
	cmp al,'s' ; 按下S键开始计时
	je q1
	cmp al,'S'
	je q1
	jmp q2
q1: 
	cli ; 使 IF 清零
	mov al, 08h
	mov ah, 35h ; 获 取 08 h 号中断的原入口地址
	INT 21H
	PUSH ES
	PUSH BX
	PUSH DS
	MOV AX,SEG TIMER_ZHONGDUAN
	MOV DS,AX
	mov dx, offset TIMER_ZHONGDUAN; 设置 08h 号中断的新入口地址
	mov al,08h
	mov ah,25h
	int 21h ; 调 用 08 h 号中断的服务程序
	pop ds
	in al,21h ;PC 机中 的8253 端口地址为 40H-43H ，这段程序应该是 给8253 初始化和写定时初值
	push ax ; 8253 是微机系统常用的定时器芯片，它有三个独立的 16 位减法计数器，每个计数器分配一个端口地址，分别为 40h,41h,42h。还有一个控制寄存器，端口地址为 43h
	mov al,11111100b
	out 21h,al
	mov al,00110110b
	out 43h,al
	mov ax,11932 ; 定时器的时钟频率 为1.193 187 MHz，计数初值 = 11931 87 / 100=1193 2
	out 40h,al
	mov al,ah
	out 40h,al
	sti
s1:
	call locate_cursor
	call SHOW
	mov ah,0bh ; 检验键盘状态，有输入 al=00 ，无输入 al=0ffh
	int 21h
	inc al
	jnz s1
	mov ah,08h;键盘输入无回显，al= 输入字符
	int 21h
	cmp al,1bh ; 按下Esc键退出计时器
	je START
	cmp al,'p' ; 按下P键停止计时
	je pause
	cmp al,'P' ; 按下p键停止计时
	je pause
	cmp al, 'z' ; 按下z键清零
	je clear
	cmp al, 'Z' ; 按下Z键清零
	je clear
	jmp s1
CLEAR:
	;pop ax
	;out 21h,al
	;pop dx ; 把 bx 送到 dx
	;pop bx
	;push ds
	;mov ds,bx
	;mov al,08h
	;mov ah,25h
	;int 21h
	;pop ds
	;mov h,0
	mov min1,30h
	mov min2,30h
	mov sec1,30h
	mov sec2,30h
	mov msec1,30h
	mov msec2,30h
	jmp start_timer
PAUSE:
	pop ax
	out 21h,al
	pop dx ; 把BX送到DX ，原中断向量存在ES:BX中
	pop bx
	push ds
	mov ds,bx
	mov al,08h
	mov ah,25h
	int 21h
	pop ds
aa1:
	mov ah,08h ; 键盘输入无回显,al= 输入字符
	int 21h
	CMP AL,1BH;按下ESC键退出计时程序
	JE START
	CMP AL,'Z'
	JE CLEAR
	CMP AL,'z'
	JE CLEAR
	cmp al, 's' ; 按下s键继续程序
	je jixu
	cmp al, 'S' ; 按下S键继续程序
	je jixu
	jmp aa1
jixu:
	jmp q1
	
TIMER_ZHONGDUAN proc near ; 使 用8253/8254 定时器 0 的中断类型 8 计时 ， 以 100 次/s 的频率发出中断 , 相当于一次中断 10ms
	PUSH AX
	PUSH DS
	MOV AX,DATAS
	mov ds,ax
	inc msec2
	cmp msec2, 3ah
	jb t
	mov msec2,30h
	inc msec1
	cmp msec1,3ah
	jb t
	mov msec1,30h
	inc sec2
	cmp sec2,3ah
	jb t
	mov sec2,30h
	inc sec1
	cmp sec1,36h
	jb t
	mov sec1,30h
	inc min2
	cmp min2,3ah
	jb t
	mov min2,30h
	inc min1
	cmp min1,36h
	jb t
	mov min1,30h
	inc hou2
	cmp hou2,3ah
	jb t
	mov hou2,30h
	inc hou1
	cmp hou1,33h
	jb t
	mov hou1,30h
t: 
	mov al,20h
	out 20h,al ; 中断结束命令
	pop ds
	pop ax
	iret ; 中断返回
TIMER_ZHONGDUAN endp ; 中断服务程序结束
	
CLEAN_SCREEN PROC NEAR
	push ax
	push bx
	push cx
	push dx
	mov ah, 6 ; 屏幕初始化或向上滚动
	mov al, 0 ; 清屏
	mov bh, 0 ; 滚入行属性
	mov ch, 0 ; 左上角行号
	mov cl, 0 ; 左上角列号
	mov dh, 24 ; 右下角行号
	mov dl, 79 ; 右下角列号
	int 10h
	pop dx
	pop cx
	pop bx
	pop ax
	ret
CLEAN_SCREEN ENDP

LOCATE_CURSOR PROC NEAR
	push dx
	push bx
	push ax
	mov dh, 2; 行号
	mov dl, 33 ; 列号
	mov bh, 0 ; 页号
	mov ah, 2 ; 置光标位置
	int 10h
	pop ax
	pop bx
	pop dx
	ret
LOCATE_CURSOR ENDP

SHOW PROC NEAR
	push cx
	push bx
	push si
	push ax
	MOV SI,OFFSET hou1
	MOV CX,count
SHOW1:
	MOV AH,0EH; 显示字符
	MOV AL,[SI]
	INT 10H
	INC SI
	LOOP SHOW1
	POP AX
	POP SI
	POP BX
	POP CX
	RET
SHOW ENDP
FUNCTION_TIMER ENDP
CODES ends
end start

