data	segment  'DATA'             ; �������ݶ�
	ary1    db   12, 23, 34, 45, 56, 67, 78 ,89, 90, 18  
	cont1 	equ  $ - ary1  
    sum1 	dw   ? 
    	
    ary2  	db   13h, 24h, 57h, 68h ,9ah, 0bch, 0cdh, 0deh, 80h, 50h
   	cont2 	equ   $ - ary2
    sum2	dw   ?
data 	ends                        ; ���ݶν���

stack	segment  stack 'STACK'      ; �����ջ��
        db  256  dup (?)
stack	ends                        ;��ջ�ν���

code    segment    'CODE'           ; ��������
        assume  cs:code, ds:data, ss:stack     
 main proc  far
    mov ax, data 
    mov ds,ax   
        
; 	lea ax, ary1                ; ��ڲ���������1��ַ         
 	mov  ax, offset ary1
    push ax
    mov  ax, cont1              ; ��ڲ���������1����                      
    push ax
    call sum         	        ; ��������ӳ���
	
;	lea si, ary2                ; ��ڲ���������2��ַ  		
	mov  ax,offset ary2         ;
	push ax

    mov  ax, cont2              ; ��ڲ���������2���� 
	push ax
	call sum 		            ; ��������ӳ��� 
	
	mov ah, 4ch 		        ;	
	int 21h			            ; ���������    
	main endp
	
;�������ƣ�sum
;���ܣ�ʵ�ֶ�����Ԫ�����  
;���õļĴ�����ax,bx,cx,bp,sp
;��ڲ���: ���ڶ�ջ�У�ǰ���ֽ�Ϊ�����׵�ַ�������ֽ�Ϊ���鳤��
;���ڲ�������
;���������ӳ�����  
		
    sum proc           	  	       ;������� sum
		push bx
		push cx
		push bp
		pushf
		mov bp,sp
		
		mov cx,[bp+10]             ;
		mov bx,[bp+12]	           ;
		
		xor ax, ax    		       ;ax��0����ź�
  next: add al, [bx]		       ;����Ԫ�����
		adc ah, 0      		       ;��λ����ah��
		inc bx 
 		loop next 
		mov [bx], ax 		       ; 
		
		popf
		pop bp
		pop cx
		pop bx      
		   
		ret		
	sum	endp 			           ; ���̽���     
    
code	ends 			           ; ����ν��� 
end   main

