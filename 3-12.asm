; multi-segment executable file template.

data segment
    ; add your data here!
    pkey db "press any key...$"
ends

stack segment
    dw   128  dup(0)
ends

code segment
start:
; set segment registers:
    mov ax, data
    mov ds, ax
    mov es, ax

    ; add your code here
    xor dx,dx ;DH存整数指针，DL存负数指针
    mov SI,2000h   
    MOV BX,2200H
    MOV DI,2100H
    mov cx,20h
loop:
    mov al,[si]
    and al,80h
    jns step1  ;是正数则跳step1
    jmp step2   ;负数跳step2
step1:      
    mov AL,[SI] 
    MOV AL,[BX]
    INC BX   
    JMP NEXT
step2:    
    MOV [DX],[SI]      
    INC DX
    JMP NEXT
NEXT:
    INC SI
    DEC CX
    JNZ LOOP
    JMP STOP
STOP:
    MOV AH,4CH
    INT 21H    
    
            
    lea dx, pkey
    mov ah, 9
    int 21h        ; output string at ds:dx
    
    ; wait for any key....    
    mov ah, 1
    int 21h
    
    mov ax, 4c00h ; exit to operating system.
    int 21h    
ends

end start ; set entry point and stop the assembler.
