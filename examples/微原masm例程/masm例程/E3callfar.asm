; multi-segment executable file template.
     
data segment        
   table  dw  0ffffh, 32h, 41h, 42h, 256, -128, -100, 48h
   tab11  dw  09h, 0ah, -11, -67, 39, 4, 20, 10h
   tab12  dw  -32768, 32768, -525, 30, 1, 2, 07h, 08h  
   msg1   db  'AaBbCcDcEe$'  
data ends     
  
stack segment stack 'stack'
    dw   128  dup(0)
stack ends

code segment  'code'
    assume  cs: code, ds: data, ss: stack
    
start: 
    mov  ax,data         ; or: seg table         ; segment addr
    mov  ds, ax          ; set ds    
    mov  es, ax          ; set es 

    call testp
       
    mov ax, 4c00h ; exit to operating system.
    int 21h    
code ends

code1 segment 'code'
    assume  cs: code1, ds: data, ss: stack
    
    ; public testp   ;  not necessary
    
  testp proc far
    
    mov ax,1234h
        
    lea dx,msg1+2
    mov ah,09
    int 21h

    retf 
    ; ret
  testp endp

code1 ends

end start ; set entry point and stop the assembler.










