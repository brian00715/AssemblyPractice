datas segment  
    bmpfname db '1.bmp', 0    ; 图片路径  
    x0 dw 0  	               ; 当前显示界面的横坐标，初始为0
    y0 dw 0            	        ; 当前显示界面的纵坐标，初始为0
    handle dw ?                ; 文件指针  
    bmpdata1 db 256*4 dup(?)   ; 存放位图文件调色板  
    bmpdata2 db 64000 dup(0)   ; 存放位图信息,64k  
    bmpwidth dw ?              ; 位图宽度  
    bmplength dw ?         	   ; 位图长度    
datas ends  
                            
stacks segment stack  
       dw 100h dup(?)  
top	label 	word
stacks ends  
                          
codes segment  
    assume cs:codes, ds:datas, ss:stacks                             
; 打开文件并存令handle指向文件  
openf proc near  
    lea dx, bmpfname           
    mov ah, 3dh  
    mov al, 0  
    int 21h  	
    mov handle, ax  
    ret  
openf endp  
                          
; 获取位图信息函数  
readf proc near  
        ; 移动文件指针,bx = 文件代号， cx:dx = 位移量， al = 0 即从文件头绝对位移  
        mov ah, 42h  
        mov al, 0  
        mov bx, handle  
        mov cx, 0  
        mov dx, 12h     ; 跳过18个字节直接指向位图的宽度信息  
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
        mov dx, 16h     ; 跳过22个字节直接指向位图的长度信息  
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
readf endp  
                           
; 设置调色板输出色彩索引号及rgb数据共写256次   
proc1 proc near  
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
       mov al, [si+2]           ;	r
       shr al, 1                
       shr al, 1  
       out dx, al  
       mov al, [si+1]  			;	g	
       shr al, 1  
       shr al, 1  
       out dx, al  
       mov al, [si]  			;	b
       shr al, 1  
       shr al, 1  
       out dx, al  
       add si, 4  
       loop l0  
       ret  
proc1 endp  
                          
proc2 proc near  
        mov bx, 0a000h          ; 写屏 
        mov es, bx  
l1:  	xor di,di  
        cld                     ; df清零  
        mov cx, y0              ; cx = 0  
l2:  	mov ax, bmpwidth        ; ax = 位图宽度  
        mov dx, ax  
        and dx, 11b  			;位图宽度是否为4倍数
        jz  l3  
        mov ax, 4  
        sub ax, dx  
        add ax, bmpwidth  		;填充
l3:  	inc cx					;cx行数
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
        mov ax, 4202h  			;向前移动cxdx个字节，无符号
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
        stosb  					;[si] -> [di],si++,di++
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
l7:     mov ah,0  				;键盘输入buffer
        int 16h  
        cmp ax, 4800h  			;up
        je  up  
        cmp ax, 5000h			;down  
        je  down 
        cmp ax, 4b00h			;left  
        je  left  
        cmp ax, 4d00h			;right  
        je  right   
        cmp ax, 011bh			;exit  
        je  exit  
        jmp l7   
up:  	mov ax, y0  
        sub ax, 20 
        jl  l7  
        mov y0, ax  
        jmp l1  
down:   mov ax, y0  
        add ax, 20
        push ax  
        add ax, 200  
        cmp ax, bmplength  
        pop ax  
        jae l7  
        mov y0,ax  
        jmp l1  
left:   mov ax, x0  
        sub ax, 20 
        jl  l7  
        mov x0, ax  
        jmp l1
right:  mov ax, x0  
        add ax, 20
        push ax  
        add ax, 320 
        cmp ax, bmpwidth  
        pop ax  
        jae l7 
        mov x0, ax  
        jmp l1 
                          
exit:   mov ax, 3  		;返回80x25x16窗口
        int 10h  
        mov ah, 4ch  
        int 21h    
proc2 endp                            
codes ends 
end     