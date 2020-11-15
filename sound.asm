;定义数据段
data segment
infor1 db 0Dh, 0AH, "welocom you to come here listeng! $"
 
;频率表
mus_freg dw 659,659,698,784,784,698 
         dw 659,587,524,524,587,659,659,587,587,-1
;节拍表
mus_time dw 15 DUP(50)
mus_length DW 15
data ends
 
;栈段定义
stack segment stack
    db 200 dup(?)
stack ends
 
;--------字符串输出宏----------
SHOWBM MACRO b
    LEA DX,b
    MOV AH,9
    INT 21H
    ENDM
 
;----------音乐地址宏-----------
ADDRESS MACRO A,B
    LEA SI,A
    LEA BP,DS:B
    ENDM
;-------------------------------
 
;代码段定义
code segment
   assume ds:data, ss:stack, cs:code
start:
    mov ax, data
    mov ds, ax
    mov ax, stack
    mov ss, ax
    mov sp, 200
    address mus_freg, mus_time
    call music
 
exit:  
    mov ah, 4cH
    int 21h
 
;------------发声-------------
gensound proc near
    push ax
    push bx
    push cx
    push dx
    push di
 
    mov al, 0b6H
    out 43h, al     ;使能8253
    mov dx, 12h
    mov ax, 348ch
    div di
    out 42h, al
 
    mov al, ah
    out 42h, al
 
    in al, 61h
    mov ah, al
    or al, 3
    out 61h, al     ;打开扬声器
wait1:
    mov cx, 3314
    call waitf
delay1:
    dec bx
    jnz wait1
 
    mov al, ah
    out 61h, al 
 
    pop di
    pop dx
    pop cx
    pop bx
    pop ax
    ret
gensound endp
 
;--------------------------
waitf proc near
     push ax
waitf1:
     in al,61h
     and al,10h
     cmp al,ah
     je waitf1
     mov ah,al
     loop waitf1
     pop ax
     ret
waitf endp
;--------------发声调用函数----------------
music proc near
     xor ax, ax
freg:
     mov di, [si]
     cmp di, 0FFFFH
     je end_mus
     mov bx, ds:[bp]
     call gensound
     add si, 2
     add bp, 2
     jmp freg
end_mus:
     ret
music endp
 
code ends
    end start