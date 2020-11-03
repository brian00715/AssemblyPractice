data	segment  'DATA'             ; 定义数据段
	ary1    db   12, 23, 34, 45, 56, 67, 78 ,89, 90, 18  
	cont1 	equ  $ - ary1  
    sum1 	dw   ? 
    	
    ary2  	db   13h, 24h, 57h, 68h ,9ah, 0bch, 0cdh, 0deh, 80h, 50h
   	cont2 	equ   $ - ary2
    sum2	dw   ?
data 	ends                        ; 数据段结束

stack	segment  stack 'STACK'      ; 定义堆栈段
        db  256  dup (?)
stack	ends                        ;堆栈段结束

code    segment    'CODE'           ; 定义代码段
        assume  cs:code, ds:data, ss:stack     
 main proc  far
    mov ax, data 
    mov ds,ax   
        
; 	lea ax, ary1                ; 入口参数，数组1首址         
 	mov  ax, offset ary1
    push ax
    mov  ax, cont1              ; 入口参数，数组1长度                      
    push ax
    call sum         	        ; 调用求和子程序
	
;	lea si, ary2                ; 入口参数，数组2首址  		
	mov  ax,offset ary2         ;
	push ax

    mov  ax, cont2              ; 入口参数，数组2长度 
	push ax
	call sum 		            ; 调用求和子程序 
	
	mov ah, 4ch 		        ;	
	int 21h			            ; 主程序结束    
	main endp
	
;过程名称：sum
;功能：实现对数组元素求和  
;所用的寄存器：ax,bx,cx,bp,sp
;入口参数: 存于堆栈中，前两字节为数组首地址；后两字节为数组长度
;出口参数：无
;调用其他子程序：无  
		
    sum proc           	  	       ;定义过程 sum
		push bx
		push cx
		push bp
		pushf
		mov bp,sp
		
		mov cx,[bp+10]             ;
		mov bx,[bp+12]	           ;
		
		xor ax, ax    		       ;ax清0，存放和
  next: add al, [bx]		       ;数组元素相加
		adc ah, 0      		       ;高位放在ah中
		inc bx 
 		loop next 
		mov [bx], ax 		       ; 
		
		popf
		pop bp
		pop cx
		pop bx      
		   
		ret		
	sum	endp 			           ; 过程结束     
    
code	ends 			           ; 代码段结束 
end   main

