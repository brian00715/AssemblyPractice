data segment


str1  db 'The data is : '
str4  db 4 dup(0),'/'
str2  db 2 dup(0),'/'
str3  db 2 dup(0),10,13,'$'


str5  db 'The time is : '
str6  db 2 dup(0),':'
str7  db 2 dup(0),':'
str8  db 2 dup(0),10,13,'$' 



str9 db 'The time-consuming is : '
str10 db 2 dup(0),':'
str11 db 2 dup(0),':'
str12 db 2 dup(0),'$'


str13 db 'The time-consuming is : 00:00:00 $'

str14 db 'Name: Chen WeiTong   number: 2014211734 $' 

str15 db 'press b to start timer function ,press s to stop it,and press r to restart it$'

str16 db 'press f to finish the program $'

str17 db 80 dup(10h),'$'



month  db  0
day  db 0
year  dw 0
hour db 0
minute db 0
secend db 0
zuobiao db 0

hour1 db 0
minute1 db 0
secend1 db 0

x1 db 0
x2 db 0
x3 db 1

data ends 


code segment public
     assume  cs:code,ds:data
     org 100h

start: jmp begin


p1 proc      						;进行ascll码的转换            
	mov si , 10
next:   xor dx, dx
	div si
	add dx,'0'
	dec bx
	mov [bx], dl
	or ax, ax
	jnz next
	ret
p1 endp




p2 proc							;进行ascll码的转换
       	 mov si,10						 
         mov cx,2
next2:   xor dx,dx
         div si
         add dx,'0'
         dec bx
         mov [bx],dl
         dec cx
         jnz next2
         ret
p2 endp




xxx1 proc 
        mov ax,0600h         				;清屏
	mov bx,0754h            
	mov cx,0000h
	mov dx,2479h
	int 10h

        mov ax,0200h         				;设置光标位置
	mov bx,0000h
	mov cx,0000h
	mov dx,0719h
	int 10h

      mov ax,data
      mov ds ,ax			   		 ;输出系统的日期 
      mov ah, 2ah
      int 21h
      mov byte ptr month,dh
      mov byte ptr day,dl 
      mov word ptr year, cx

      mov bx,offset str4 + 4
      mov ax,word ptr year
      call p1

      mov bx,offset str2+2
      xor ax,ax
      mov al,byte ptr month
      call p1
      mov bx, offset str3+2 
      xor ax,ax
      mov al,byte ptr day
      call p1
      
      mov dx,offset str1
      mov ah ,09
      int 21h
ret
xxx1 endp



xxx2 proc

        mov ax,0200h                       ;设置光标
	mov bx,0000h 
	mov cx,0000h
	mov dx,0919h
	int 10h
     
      mov ah, 2ch                          ;输出系统时间
      int 21h
      mov byte ptr secend,dh  
      mov byte ptr minute,cl 
      mov byte ptr hour, ch


      mov bx,offset str6 + 2
      xor ax,ax
      mov al,byte ptr hour
      call p2

      mov bx,offset str7+2
      xor ax,ax
      mov al,byte ptr minute
      call p2
      mov bx, offset str8+2
      xor ax,ax
      mov al,byte ptr secend
      call p2

      mov dx,offset str5
      mov ah ,09
      int 21h
ret
xxx2 endp


xxx3 proc
	mov ax,0200h        		 ;设置光标
	mov bx,0000h
	mov cx,0000h
	mov dx,0b19h
	int 10h
	cmp x1,'s'
	je next9
	inc secend1           		;完成计时时间的显示
	cmp secend1,60
	jnz next9
	mov secend1,0
	inc minute1
	cmp minute1,60
	jnz next9
	inc hour1

next9:  nop

        mov bx,offset str10 + 2
	xor ax,ax
        mov al,byte ptr hour1
        call p2

        mov bx,offset str11+2
        xor ax,ax
        mov al,byte ptr minute1
        call p2
        mov bx, offset str12+2
        xor ax,ax
        mov al,byte ptr secend1
        call p2

        mov dx,offset str9
        mov ah ,09
        int 21h

ret
xxx3 endp



xxx4 proc
	mov ax,0200h         			;设置光标位置
	mov bx,0000h          		
	mov cx,0000h
	mov dx,0b19h
	int 10h
	mov hour1 , 0
	mov minute1 ,0
	mov secend1 , 0

	mov dx,offset str13			;输出字符串13
        mov ah ,09
        int 21h
ret
xxx4 endp




xxx5 proc

 	mov ax,0200h        			;输出字符串14
	mov bx,0000h
	mov cx,0000h
	mov dx,0313h
	int 10h

	mov dx,offset str14
        mov ah ,09
        int 21h

ret
xxx5 endp



xxx6 proc					;输出字符串15

 	mov ax,0200h        
	mov bx,0000h
	mov cx,0000h
	mov dx,1001h
	int 10h

	mov dx,offset str15
        mov ah ,09
        int 21h

ret
xxx6 endp



xxx7 proc					;输出字符串16

 	mov ax,0200h        
	mov bx,0000h
	mov cx,0000h
	mov dx,1217h
	int 10h

	mov dx,offset str16
        mov ah ,09
        int 21h

ret
xxx7 endp



xxx8 proc					;输出三角形

    	mov ax,0600h    			;设置第0行输出的颜色                    
    	mov bh,0
    	mov bl,00h
    	mov cx,0000h
    	mov dx,0079h
    	int 10h   


	mov ax,0600h    			;设置第1行输出的颜色                    
    	mov bh,x3
    	mov bl,00h
    	mov cx,0100h
    	mov dx,0179h
    	int 10h   



    	mov ax,0600h                            ;设置第22行的输出颜色
    	mov bh,0
 	mov bl,00h
 	mov cx,1600h
 	mov dx,1679h
  	int 10h   
	
	mov ax,0600h    			;设置第23行输出的颜色                    
    	mov bh,x3
    	mov bl,00h
    	mov cx,1700h
    	mov dx,1779h
    	int 10h 

	inc x3
	cmp x3,7  
	je  dfd
	jmp gfg
dfd:    mov x3,1

	
gfg: 	mov ax,0200h                             ;循环改变设置光标位置使字符不断输出形成动画       
	mov bx,0000h
	mov cx,0000h
	mov dh,00h
	mov dl, zuobiao
	int 10h
   	mov dx,offset str17
        mov ah ,09
        int 21h


 	mov ax,0200h        
	mov bx,0000h
	mov cx,0000h
	mov dh,16h
	mov dl, zuobiao
	int 10h

	
	
	inc  zuobiao
	mov dx,offset str17
        mov ah ,09
        int 21h
	cmp zuobiao, 79
	je ccc

	jmp vvv


ccc:	mov zuobiao,0				;当动画放完一遍后重置光标位置

vvv:

ret
xxx8 endp



begin:						;主程序

	cmp x1,'f'
	je finish
	call xxx1
	call xxx2
	call xxx5
	call xxx6
	call xxx7
	call xxx8
 shuru1:   mov ah,0bh				;判断有无输入
           int 21h
           cmp al,00h                 
           je next333
           mov ah,00h
    	   int 16h				;判断输入的字符是什么
	   mov x1,al
	   cmp al,'s'
	   jne next333	                          
           cmp al,'b'                           
           jne next333
	  
next222:  
	  call xxx3
          jmp next111

next333:  
	  cmp x1,'s'
	  je  next222
	  cmp x1,'b'
	  je  next222
	  call xxx4

next111: mov ah, 2ch
         int 21h
	 xor dh,secend
	 jnz begin

         jmp next111

 finish:   					;退出程序
	mov ax,0600h        			;清屏
	mov bx,0754h            
	mov cx,0000h
	mov dx,2479h
	int 10h

	mov ax,0200h       			;设置光标位置
	mov bx,0000h
	mov cx,0000h
	mov dx,0001h
	int 10h


        mov ah,4ch
        int 21h
code   ends
      end start
