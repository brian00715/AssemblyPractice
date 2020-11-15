data segment'data'
	today db 'Today is',':'	;设置显示字符串“today is”
	k1 db 4 dup(0),'/'	;为年月日设置单元
	k2 db 2 dup(0),'/'
	k3 db 2 dup(0),'$'
	curret db 'Curret time is',':'	;设置当前时间字符串
	k4 db 2 dup(0),':'		;为时分秒设置单元
	k5 db 2 dup(0),':'
	k6 db 2 dup(0),'$'
	year dw 0	;暂存年月日时分秒的单元
	month db 0
	day db 0
	hour db 0
	min db 0
	sec db 0
	c0 db 'Count:'	;设置显示计时的字符串“count”
	c1 db 2 dup(0),':'	;为计时的小时，分钟，秒设置单元
	c2 db 2 dup(0),':'
	c3 db 2 dup(0),'$'
	h1 db 0			;暂存计时的时分秒单元
	m1 db 0
	s1 db 0
	j db 0			;用于判断计时条件
	g db 1			;用于判断显示字符LMA的条件
;----------------分割线-------------------
;设置要显示的文字
	sw1 db 15 dup(0eh,20h),'$'
	sw2 db 0eh,'   press c to Count        ',0eh,'$'
	sw3 db 0eh,'   press r to Reset        ',0eh,'$'
	sw4 db 0eh,'   press SPACE to Stop     ',0eh,'$'
	sw5 db 0eh,'   press ESC to Exit       ',0eh,'$'
	sw9 db 15 dup(0eh,20h),'$'
	sw6 db '   made by:  Li Mengao       ','$'
	sw7 db '   class:    2014211402        ','$'
	sw8 db '   studentID:2014211741    ','$'
;--------------分割线------------------------------
;设置要显示的LMA字符
	lma1 db 'L','$'
	lma2 db 6 dup('L'),'$'
	lma3 db 'M         M','$'
	lma4 db 'M M     M M','$'
	lma5 db 'M  M   M  M','$'
	lma6 db 'M   M M   M','$'
	lma7 db 'M    M    M','$'
	lma8 db '    A','$'
	lma9 db '   A A ','$'
       lma10 db '  AAAAA ','$'
       lma11 db ' A     A ','$'
       lma12 db 'A       A' ,'$'
data ends

code segment 'code'			;数据段声明
	assume cs:code,ds:data

;将要显示的数字转换成双位的ASCII码即显示格式为数字“xx”
num2asc proc
        mov di,10
        cmp ax,10      ;取出的数若小于10则单独处理
        jl next1
next:   xor dx,dx 		;被除数高十六位在dx中
        div di 			;di为除数10，余数在dx中
        add dx,'0' 		;余数转化ASCII码
        dec bx
        mov [bx],dl
        or ax,ax 		;判断商是否为零
        jnz next
        jmp fin
next1:  add al,30h     ;若AX<10,则先转换个位
        dec bx
        mov [bx],al
        mov al,'0'     ;十位置0
        dec bx
        mov [bx],al
fin:    ret          
num2asc endp

clscr proc			;清屏代码过程定义
	mov ax,0600h		;功能调用号ah=06h
	mov bx,0754h
	mov cx,0000h
	mov dx,194fh
	int 10h			;BIOS功能调用的中断
	ret
clscr endp


show macro a,b		;定义宏指令cursor （设置光标及打印字符串）
	mov bh,0
	mov dx,a		;将参数a传给dx以设置光标坐标
	mov ah,2		;功能调用号2h
	int 10h			;调用BIOS功能设置光标
	mov dx,offset b		;将要打印的字符的首地址传入dx
	mov ah,9		;功能调用号9h
	int 21h			;调用dos功能 打印字符
endm

;设置显示LMA
showlma1 proc			;该过程显示LMA三个图形
	mov ax,0600H
        mov bh,34h 			;设置L的背景色为青色，红色为前景色，显示L字符组成的L图形
        mov cx,0c10H 			;窗口左上角第12行第16列到窗口右下角第16行23列区域
        mov dx,1017H 			
        int 10h
;开始显示L
	show 0c10h,lma1
	show 0d10h,lma1
	show 0e10h,lma1
	show 0f10h,lma1
	show 1010h,lma2
	
	mov ax,0600H			
        mov bh,32h 			;设置M的背景色为青色，前景色为绿色
        mov cx,0c23H 			;同L的设置方式
        mov dx,1030H 			
        int 10h
;开始显示M
	show 0c23h,lma3
	show 0d23h,lma4
	show 0e23h,lma5
	show 0f23h,lma6
	show 1023h,lma7

	mov ax,0600H
        mov bh,31h 			;设置A的背景色为青色，前景色为蓝色
        mov cx,0c3bH 			;同L的设置方式
        mov dx,104bH 
        int 10h
;开始显示A
	show 0c3bh,lma8
	show 0d3bh,lma9
	show 0e3bh,lma10
	show 0f3bh,lma11
	show 103bh,lma12
	ret
showlma1 endp

;仅显示图形L
showlma2 proc
	mov ax,0600H
        mov bh,34h 
        mov cx,0c10H 
        mov dx,1017H 
        int 10h
	show 0c10h,lma1
	show 0d10h,lma1
	show 0e10h,lma1
	show 0f10h,lma1
	show 1010h,lma2
	
	mov ax,0600H
        mov bh,33h 			;将M区域的背景色和前景色设为一样,由此覆盖M图案
        mov cx,0c23H 		
        mov dx,1030H 		
        int 10h

	mov ax,0600H
        mov bh,33h 			;同M的设置
        mov cx,0c3bH 			
        mov dx,104bH 			
        int 10h
	ret

;仅显示图案M，设置与L相同
showlma2 endp


showlma3 proc
	mov ax,0600H
        mov bh,33h 
        mov cx,0c10H 
        mov dx,1017H
        int 10h
	
	mov ax,0600H
        mov bh,32h 
        mov cx,0c23H 
        mov dx,1030H 			
        int 10h
	show 0c23h,lma3
	show 0d23h,lma4
	show 0e23h,lma5
	show 0f23h,lma6
	show 1023h,lma7
	
	mov ax,0600H
        mov bh,33h 			
        mov cx,0c3bH 
        mov dx,104bH 
        int 10h
	ret
showlma3 endp

;仅显示A图案，设置方式与L,M相同
showlma4 proc
	mov ax,0600H
        mov bh,33h 
        mov cx,0c10H
        mov dx,1017H
        int 10h
	
	mov ax,0600H
        mov bh,33h 
        mov cx,0c23H 
        mov dx,1030H 
        int 10h

	mov ax,0600H
        mov bh,31h
        mov cx,0c3bH 
        mov dx,104bH 
        int 10h
	show 0c3bh,lma8
	show 0d3bh,lma9
	show 0e3bh,lma10
	show 0f3bh,lma11
	show 103bh,lma12
	ret
showlma4 endp
		

zcun macro x, y 			;定义宏指令zcun，形参为x，y
	mov bx, offset x
	xor ax, ax
	mov al, byte ptr y 		;将没转换的二进制数放入al
	call num2asc 			;调用转换为ASCII码的子程序
	endm 	

;主程序
start:	mov ax,data			;给ds赋值，让其指向数据段data
	mov ds,ax
	
	call clscr			;调用清屏

	mov ax,0600h
        mov bh,30h 			;设置背景色为青色，前景色为黑
        mov cx,0000h
        mov dx,2f4fh
       	int 10h 
	
now1:	show 121ah,sw1 			;显示文字
	show 131ah,sw2 
	show 141ah,sw3
	show 151ah,sw4
	show 161ah,sw5 
	show 171ah,sw9
	
	show 081ch,sw6 
	show 091ch,sw7
	show 0a1ch,sw8
	
	mov ah,2ah			;取日期
	int 21h
	mov word ptr year,cx		;将取得的年月日存入已声明好的代表年月日的内存中
	mov byte ptr month,dh
	mov byte ptr day,dl
	
	xor ax,ax			;将ax清零
	mov ax,word ptr year		;把年的数值赋给ax让其完成ascii码的转换
	mov bx,offset k1+4		;将申请好存放年的内存偏移地址的首地址穿给bx,使其在转换ASCii码时可以此将字符串存入地址
	call num2asc			;调用转ASCII码的过程

;月，日的过程与取年相同	
	xor ax,ax
	mov al,byte ptr month
	mov bx,offset k2+2
	call num2asc
	
	xor ax,ax
	mov al,byte ptr day
	mov bx,offset k3+2
	call num2asc
	
	show 031fh,today		;显示年月日
	
now2:	mov ah,2ch			;取时间，方式与年月日相同
	int 21h 

	mov byte ptr hour,ch
	mov byte ptr min,cl
	mov byte ptr sec,dh

	xor ax,ax
	mov al,byte ptr hour
	mov bx,offset k4+2
	call num2asc
	
	xor ax,ax
	mov al,byte ptr min
	mov bx,offset k5+2
	call num2asc

	xor ax,ax
	mov al,byte ptr sec
	mov bx,offset k6+2
	call num2asc
	
	show 041dh,curret		;显示时间

;开始设置计时
rightnow: mov ah,2ch			;再取时间
	int 21h
	mov al,byte ptr sec		;将上一次取的秒赋给al
	cmp al,dh			;将这一次与上一次的秒相比较
	jz rightnow			;如果相等，跳转rightnow再取时间比较
	mov ah,1			;如果不等则判断是否有按键键入
	int 16h
	jz help 			;没有键按下则判断辅助程序
	mov ah, 0              		;若有键按下则检测按下哪个键
	int 16h
	cmp al,'c'			;检测是否为c，是则进行计数
	jz count
	cmp al,'r'			;检测是否为r，是则重新开始计数
	jz reset
	cmp al,20h			;检测是否为空格键（space），是则暂停
	jz stop	
	cmp al,1bh			;检测是否为ESC键，是则退出
	jz exit
	jmp now2			;都没有就跳回显示时间的过程

help:	cmp j,1				;辅助判断
	jz count			;j值与1相等，即已经按下计时键则跳转到计时
	jmp now2			;j值与1不等，即无按键键入也未要求显示计时时，跳转now2，继续显示当前时间

count:	mov j,1				;计时
        inc s1
        cmp s1,60
        jb counts			;显示
        inc m1 				;秒数超过60后向分钟进位
        mov s1,00			;将秒数复位为00，后面也相同
        cmp m1,60
        jb counts
        inc h1 				;分钟超过60后向小时进位
        mov m1,00
	
stop:	mov j,00			;暂停设置
	jmp now2

reset:  mov h1, 00 			;复位计时，全部清零
        mov m1, 00
        mov s1, 00
        jmp now2 

exit:	mov ah,4ch			;按下esc键跳转此处退出dos
	int 21h

counts:	zcun c1+2,h1			;将时分秒单元暂存
	zcun c2+2,m1
	zcun c3+2,s1
	cmp g,1				;判断g与1是否相等，相等则显示LMA
	jz showal
	cmp g,2				;判断g与2是否相等，相等则仅显示L
	jz showl
	cmp g,3				;判断g与3是否相等，相等则仅显示M
	jz showm
	cmp g,4				;判断g与4是否相等，相等则仅显示A
	jz showa
showal:call showlma1			;显示LMA
	mov g,2				;显示完成后将g设为2
	jmp showc			;跳转显示计时
showl:	call showlma2			;显示L
	mov g,3				;显示完成将g设为3
	jmp showc
showm:	call showlma3
	mov g,4				;显示完成将g设为4
	jmp showc
showa:	call showlma4
	mov g,1				;显示完成将g设为1
	jmp showc
;显示计时
showc:	show 0521h,c0
	jmp now2

code ends				;数据段结束
end start				;程序结束
	
