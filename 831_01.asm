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
;��ʾ���
FUNCTION_MENU PROC NEAR
    MOV AH,09H
    MOV DX,OFFSET MENU
    INT 21H
;��ʾ������
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


DIVNUM PROC NEAR ;������תBCD��
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
	mov ax,0600H;ah=06(����)al=00(ȫ���հ�)
	mov bh,000fH;���ñ�����ɫ(3)��ǰ����ɫ(F)
	SUB CX,CX
	MOV DX,5F5FH
	INT 10H
	POP AX
	POP BX
	MOV DH,1; �к�
	MOV DL,0 ; �к�
	MOV BH,0 ; ҳ��
	MOV AH,2 ; �ù��λ��
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
	mov ah,08h ; ���������޻��ԣ� al= �����ַ�
	int 21h
	cmp al, 1bh ; ���� Esc ����������
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
	cmp al,'s' ; ����S����ʼ��ʱ
	je q1
	cmp al,'S'
	je q1
	jmp q2
q1: 
	cli ; ʹ IF ����
	mov al, 08h
	mov ah, 35h ; �� ȡ 08 h ���жϵ�ԭ��ڵ�ַ
	INT 21H
	PUSH ES
	PUSH BX
	PUSH DS
	MOV AX,SEG TIMER_ZHONGDUAN
	MOV DS,AX
	mov dx, offset TIMER_ZHONGDUAN; ���� 08h ���жϵ�����ڵ�ַ
	mov al,08h
	mov ah,25h
	int 21h ; �� �� 08 h ���жϵķ������
	pop ds
	in al,21h ;PC ���� ��8253 �˿ڵ�ַΪ 40H-43H ����γ���Ӧ���� ��8253 ��ʼ����д��ʱ��ֵ
	push ax ; 8253 ��΢��ϵͳ���õĶ�ʱ��оƬ���������������� 16 λ������������ÿ������������һ���˿ڵ�ַ���ֱ�Ϊ 40h,41h,42h������һ�����ƼĴ������˿ڵ�ַΪ 43h
	mov al,11111100b
	out 21h,al
	mov al,00110110b
	out 43h,al
	mov ax,11932 ; ��ʱ����ʱ��Ƶ�� Ϊ1.193 187 MHz��������ֵ = 11931 87 / 100=1193 2
	out 40h,al
	mov al,ah
	out 40h,al
	sti
s1:
	call locate_cursor
	call SHOW
	mov ah,0bh ; �������״̬�������� al=00 �������� al=0ffh
	int 21h
	inc al
	jnz s1
	mov ah,08h;���������޻��ԣ�al= �����ַ�
	int 21h
	cmp al,1bh ; ����Esc���˳���ʱ��
	je START
	cmp al,'p' ; ����P��ֹͣ��ʱ
	je pause
	cmp al,'P' ; ����p��ֹͣ��ʱ
	je pause
	cmp al, 'z' ; ����z������
	je clear
	cmp al, 'Z' ; ����Z������
	je clear
	jmp s1
CLEAR:
	;pop ax
	;out 21h,al
	;pop dx ; �� bx �͵� dx
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
	pop dx ; ��BX�͵�DX ��ԭ�ж���������ES:BX��
	pop bx
	push ds
	mov ds,bx
	mov al,08h
	mov ah,25h
	int 21h
	pop ds
aa1:
	mov ah,08h ; ���������޻���,al= �����ַ�
	int 21h
	CMP AL,1BH;����ESC���˳���ʱ����
	JE START
	CMP AL,'Z'
	JE CLEAR
	CMP AL,'z'
	JE CLEAR
	cmp al, 's' ; ����s����������
	je jixu
	cmp al, 'S' ; ����S����������
	je jixu
	jmp aa1
jixu:
	jmp q1
	
TIMER_ZHONGDUAN proc near ; ʹ ��8253/8254 ��ʱ�� 0 ���ж����� 8 ��ʱ �� �� 100 ��/s ��Ƶ�ʷ����ж� , �൱��һ���ж� 10ms
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
	out 20h,al ; �жϽ�������
	pop ds
	pop ax
	iret ; �жϷ���
TIMER_ZHONGDUAN endp ; �жϷ���������
	
CLEAN_SCREEN PROC NEAR
	push ax
	push bx
	push cx
	push dx
	mov ah, 6 ; ��Ļ��ʼ�������Ϲ���
	mov al, 0 ; ����
	mov bh, 0 ; ����������
	mov ch, 0 ; ���Ͻ��к�
	mov cl, 0 ; ���Ͻ��к�
	mov dh, 24 ; ���½��к�
	mov dl, 79 ; ���½��к�
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
	mov dh, 2; �к�
	mov dl, 33 ; �к�
	mov bh, 0 ; ҳ��
	mov ah, 2 ; �ù��λ��
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
	MOV AH,0EH; ��ʾ�ַ�
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

