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
    mov AX,2000H
    MOV DX,AX
    MOV SS,AX
    MOV BX,2050H
    MOV SI,BX
    MOV DI,3050H
    MOV SI,DI
    MOV SP,5FFFH
    MOV CL,25
    
    MOV BL,CL
    MOV AH,0F0H
    MOV CH,AH
    MOV BYTE PTR [DI],64
    MOV WORD PTR [SI],256
              
    ; add your code here
            
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
