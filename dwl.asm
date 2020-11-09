data segment
    data0 db 'TODAY Is '             ;�����������
    data1 db 4 dup(0),'/'
    data2 db 2 dup(0),'/'
    data3 db 2 dup(0),10,13,'$'
    year dw 0
    month db 0
    day db 0
    
    time0 db 'The Time Is '           ;ʱ���������
    time1 db 2 dup(0),':'
    time2 db 2 dup(0),':'
    time3 db 2 dup(0),10,13,'$'
    hour db 0
    minute db 0                
    second db 0 
    
    watch0 db 'The Time-Consuming Is '      ;��ʱ�������
    watch1 db 2 dup(0),':'
    watch2 db 2 dup(0),':'
    watch3 db 2 dup(0),'$' 
    cnthour db 0
    cntminute db 0
    cntsecond db 0
    
    jishi db 'The time-consuming is 00:00:00 $ '      ;����˵���������
    student db 'Name: Du Wenli $'
    number db 'Number: 2015211756 $'
    instru1 db 'Press B To Begin Timer Function$'
    instru2 db 'Press F To Finish The Program$'    
    instru3 db 'Press S To Stop The Program$'
    instru4 db 'Press R To Restart The Program$'
    zifu db 0 
    
    bd0 db '*$'                                          ;������״�������
    bd1 db '              * *       * *$'  
    bd2 db '  * * * * * * * * * * * * * * * * * * * $'
    bd3 db '  * * * * * * * * * * * * * * * * * * * $'  
    
    shi1 db 'My wishes come true $'                     ;Ӣ��ʫ�������
    shi2 db 'When I catch the meteor shower $'
    shi3 db 'In my hands with you $'
    shi4 db 'Wish you have a good day! $'  
        
    hang1 db 0                          ;���������������
    hang2 db 5 
    hang3 db 8
    hang4 db 3
    hang5 db 1 
    hang6 db 6
    hang7 db 2
    hang8 db 7
    hang9 db 4
    xx db 04h, '$'     
    
data ends


code segment public  
    assume cs: code,ds: data
    org 100h

start: jmp begin   
    
    toasc proc          ;ת��asc���ӳ��� ��Ҫ��ʾ������ת��Ϊ˫λasc��
        mov di, 10 
        cmp ax, 10      ;��ȡ������С��ʮ�򵥶�����
        jl next1
    next:               
        xor dx, dx      ;��������ʮ��λ��dx��
        div di          ;diΪ����10��������dx��
        add dx, '0'     ;����ת��ASCII��
        dec bx
        mov [bx], dl
        or ax, ax       ;�ж����Ƿ�Ϊ��
        jnz next 
        jmp next2 
    next1:
        add al, 30h     ;��AX<10,����ת����λ
        dec bx
        mov [bx], al
        mov al,'0'      ;ʮλ��0
        dec bx
        mov [bx], al
    next2:
        ret
    toasc endp
    
    printdate proc           ;��ʾ�����ӳ���
        mov ax, 0200h        ;���ù��λ���ڣ�05,0b����
        mov bx, 0000h
        mov cx, 0000h    
        mov dx, 050bh
        int 10h 
        
        mov ax, 0600h   ;�豳��ɫΪ��ɫ��ǰ��ɫΪ��ɫ������Ϊ��05,0b������05,23��
        mov bx, 0700h
        mov cx, 050bh
        mov dx, 0523h
        int 10h
        
        mov ah, 2ah     ;ȡ����
        int 21h
        mov word ptr year, cx     ;��ȡ���������մ����ڴ���
        mov byte ptr month, dh
        mov byte ptr day, dl  
    
        mov bx, offset data1+4    ;���ת��Ϊasc��
        xor ax, ax                 
        mov ax, word ptr year
        call toasc    
    
        mov bx, offset data2+2    ;�·�ת��Ϊasc��
        xor ax, ax 
        mov al, byte ptr month
        call toasc
    
        mov bx, offset data3+2    ;����ת��Ϊasc��
        xor ax, ax
        mov al, byte ptr day
        call toasc 
    
        mov dx, offset data0      ;��ʾ ������
        mov ah, 09
        int 21h
        ret
    printdate endp   
    
    printtime proc                ;��ʾʱ���ӳ���
        mov ax, 0200h     ;���ù��λ��
        mov bx, 0000h
        mov cx, 0000h      
        mov dx, 060bh
        int 10h      
        
        mov ax, 0600h     ;�豳��ɫ��ɫ��ǰ��ɫ��ɫ
        mov bx, 0700h
        mov cx, 060bh
        mov dx, 0623h
        int 10h
        
        mov ah, 2ch              ;ȡʱ��
        int 21h
        mov byte ptr hour, ch
        mov byte ptr minute, cl
        mov byte ptr second, dh 
       
        mov bx, offset time1+2   ;Сʱת��
        xor ax, ax
        mov al, byte ptr hour
        call toasc    
        
        mov bx, offset time2+2   ;����ת��
        xor ax, ax
        mov al, byte ptr minute   
        call toasc
        
        mov bx, offset time3+2    ;��ת��
        xor ax, ax
        mov al, byte ptr second
        call toasc
        
        mov dx, offset time0      ;��ʾ
        mov ah, 09h
        int 21h
        ret
    printtime endp
    
    clock proc            ;��ʱ�����ӳ���
        mov ax, 0200h      ;���ù��λ��
        mov bx, 0000h
        mov cx, 0000h
        mov dx, 0805h
        int 10h         
        
        mov ax, 0600h       ;�豳��ɫ��ɫ��ǰ��ɫ��ɫ
        mov bx, 0700h
        mov cx, 0805h
        mov dx, 0825h
        int 10h
        
        cmp zifu,'s'       ;���ý�λ�����ȿ�zifu�������Ƿ���s��������ʱ���벻�ٽ��мӼ�����������ʼ��ʱ
        je next4
        inc cntsecond
        cmp cntsecond, 60
        jnz next4
        mov cntsecond, 0
        inc cntminute
        cmp cntminute, 60
        jnz next4
        inc cnthour  
       
    next4:                         ;��ʾ��ʱ
        nop
        mov bx, offset watch1+2
        xor ax, ax
        mov al, byte ptr cnthour
        call toasc
        
        mov bx, offset watch2+2
        xor ax, ax
        mov al, byte ptr cntminute
        call toasc
        
        mov bx, offset watch3+2
        xor ax, ax
        mov al, byte ptr cntsecond
        call toasc
        
        mov dx, offset watch0
        mov ah, 09h
        int 21h
        
        ret
    clock endp 
    
    initial proc             ;��ʱ����ʼ���ӳ���
        mov ax, 0200h
        mov bx, 0000h
        mov cx, 0000h
        mov dx, 0805h
        int 10h    
        
        mov ax, 0600h          ;�豳��ɫ��ɫ��ǰ��ɫ��ɫ
        mov bx, 0700h
        mov cx, 0805h
        mov dx, 0825h
        int 10h
        
        mov cnthour, 0
        mov cntminute, 0
        mov cntsecond, 0
        
        mov dx, offset jishi
        mov ah, 09h
        int 21h
        
        ret
    initial endp 
    
    xianshi macro p, q        ;��ʾ��ʾ��ĺ�
        mov ax, 0200h         ;���ù��λ��Ϊp
        mov bx, 0000h
        mov cx, 0000hH
        mov dx, p
        int 10h
        
        mov dx, offset q      ;��Ҫ��ӡ���ַ��׵�ַ����dx
        mov ah, 09h
        int 21h               ;����dos���ܴ�ӡ�ַ�
    endm    
   
    xianshi1 macro p, q, cor, m, n       ;��ʾ������ɫ�ִ��ĺ�
        mov ax, 0200h          ;���ù��λ��Ϊp
        mov bx, 0000h
        mov cx, 0000h
        mov dx, p 
        int 10h

        mov ax, 0600h         ;���ñ���ɫǰ��ɫ����ΧΪ��m��n
        mov bx, cor
        mov cx, m
        mov dx, n
        int 10h
                
        mov dx, offset q      ;��Ҫ��ӡ���ַ��׵�ַ����dx
        mov ah, 09h 
        int 21h
    endm    
    
    printxx1 proc              ;��ӡ�����ӳ���1
        mov ax, 0600h          ;���ñ���ɫ��ɫ��ǰ��ɫ��ɫ
        mov bx, 0e00h
        mov cx, 002ch
        mov dx, 092ch
        int 10h
        
        mov ax, 0200h          ;���ÿ�ʼ��ʾ������Ϊ��hang1�У���2ch��
        mov bx, 0000h
        mov cx, 0000h
        mov dh, hang1
        mov dl, 2ch
        int 10h
        
        inc hang1              ;������һ
        mov dx, offset xx      ;�ڵ�ǰλ����ʾ�����ַ�
        mov ah, 09h
        int 21h
        cmp hang1, 0ah         ;����ǰ��������0ahʱ����������Ϊ0���������
        je chongzhi1
        jmp jieshu1
    
    chongzhi1:                 ;��������
        mov hang1, 0
    jieshu1:
        ret
    printxx1 endp     
        
    printxx2 proc              ;��ʾ�����ӳ���2 ͬ��
        mov ax, 0600h         
        mov bx, 0e00h
        mov cx, 0030h
        mov dx, 0930h
        int 10h
        
        mov ax, 0200h
        mov bx, 0000h
        mov cx, 0000h
        mov dh, hang2
        mov dl, 30h
        int 10h
        
        inc hang2
        mov dx, offset xx
        mov ah, 09h
        int 21h
        cmp hang2, 0ah
        je chongzhi2
        jmp jieshu2
    
    chongzhi2:
        mov hang2, 0
    jieshu2:
        ret
    printxx2 endp 
    
    printxx3 proc             ;��ʾ�����ӳ���3 ͬ��
        mov ax, 0600h          
        mov bx, 0e00h
        mov cx, 0034h
        mov dx, 0934h
        int 10h
        
        mov ax, 0200h
        mov bx, 0000h
        mov cx, 0000h
        mov dh, hang3
        mov dl, 34h
        int 10h
        
        inc hang3
        mov dx, offset xx
        mov ah, 09h
        int 21h
        cmp hang3, 0ah
        je chongzhi3
        jmp jieshu3
    
    chongzhi3:
        mov hang3, 0
    jieshu3:
        ret
    printxx3 endp 
    
    printxx4 proc              ;��ʾ�����ӳ���4 ͬ��
        mov ax, 0600h         
        mov bx, 0e00h
        mov cx, 0038h
        mov dx, 0938h
        int 10h
        
        mov ax, 0200h
        mov bx, 0000h
        mov cx, 0000h
        mov dh, hang4
        mov dl, 38h
        int 10h
        
        inc hang4
        mov dx, offset xx
        mov ah, 09h
        int 21h
        cmp hang4, 0ah
        je chongzhi4
        jmp jieshu4
    
    chongzhi4:
        mov hang4, 0
    jieshu4:
        ret
    printxx4 endp 
    
    printxx5 proc              ;��ʾ�����ӳ���5 ͬ��
        mov ax, 0600h          
        mov bx, 0e00h
        mov cx, 003ch
        mov dx, 093ch
        int 10h
        
        mov ax, 0200h
        mov bx, 0000h
        mov cx, 0000h
        mov dh, hang5
        mov dl, 3ch
        int 10h
        
        inc hang5
        mov dx, offset xx
        mov ah, 09h
        int 21h
        cmp hang5, 0ah
        je chongzhi5
        jmp jieshu5
    
    chongzhi5:
        mov hang5, 0
    jieshu5:
        ret
    printxx5 endp     

    printxx6 proc              ;��ʾ�����ӳ���6 ͬ��
        mov ax, 0600h          
        mov bx, 0e00h
        mov cx, 0040h
        mov dx, 0940h
        int 10h
        
        mov ax, 0200h
        mov bx, 0000h
        mov cx, 0000h
        mov dh, hang6
        mov dl, 40h
        int 10h
        
        inc hang6
        mov dx, offset xx
        mov ah, 09h
        int 21h
        cmp hang6, 0ah
        je chongzhi6
        jmp jieshu6
    
    chongzhi6:
        mov hang6, 0
    jieshu6:
        ret
    printxx6 endp  
    
    printxx7 proc              ;��ʾ�����ӳ���7 ͬ��
        mov ax, 0600h        
        mov bx, 0e00h
        mov cx, 0044h
        mov dx, 0944h
        int 10h
        
        mov ax, 0200h
        mov bx, 0000h
        mov cx, 0000h
        mov dh, hang7
        mov dl, 44h
        int 10h
        
        inc hang7
        mov dx, offset xx
        mov ah, 09h
        int 21h
        cmp hang7, 0ah
        je chongzhi7
        jmp jieshu7
    
    chongzhi7:
        mov hang7, 0
    jieshu7:
        ret
    printxx7 endp
    
    printxx8 proc              ;��ʾ�����ӳ���8 ͬ��
        mov ax, 0600h         
        mov bx, 0e00h
        mov cx, 0048h
        mov dx, 0948h
        int 10h
        
        mov ax, 0200h
        mov bx, 0000h
        mov cx, 0000h
        mov dh, hang8
        mov dl, 48h
        int 10h
        
        inc hang8
        mov dx, offset xx
        mov ah, 09h
        int 21h
        cmp hang8, 0ah
        je chongzhi8
        jmp jieshu8
    
    chongzhi8:
        mov hang8, 0
    jieshu8:
        ret
    printxx8 endp
    
    printxx9 proc              ;��ʾ�����ӳ���9 ͬ��
        mov ax, 0600h          
        mov bx, 0e00h
        mov cx, 004ch
        mov dx, 094ch
        int 10h
        
        mov ax, 0200h
        mov bx, 0000h
        mov cx, 0000h
        mov dh, hang9
        mov dl, 4ch
        int 10h
        
        inc hang9
        mov dx, offset xx
        mov ah, 09h
        int 21h
        cmp hang9, 0ah
        je chongzhi9
        jmp jieshu9
    
    chongzhi9:
        mov hang9, 0
    jieshu9:
        ret
    printxx9 endp    
                
    begin:                   ;�����򲿷�
        mov ax, data
        mov ds, ax    
        
        mov ax, 0600h        ;����
        mov bx, 0754h
        mov cx, 0000h
        mov dx, 2479h
        int 10h  
        
        mov ax, 0600h      ;���ñ�����ɫΪ��ɫ��ǰ����ɫΪ��ɫ����ΧΪ��0,0������2fh��4fh��
        mov bx, 0300h
        mov cx, 0000h
        mov dx, 2f4fh
        int 10h
        
        xianshi1 1640h, student, 0700h, 1640h, 165fh   ;��ʾ�ַ�������������Ϊ���λ�ã��ִ��׵�ַ������ɫǰ��ɫ���ã��Լ���Χ
        xianshi1 173ch, number, 0700h, 173ch, 175fh    ;���Ǳ���ɫΪ��ɫ��ǰ��ɫΪ��ɫ
        xianshi1 1005h, instru1, 0700h, 1005h, 1025h
        xianshi1 1105h, instru2, 0700h, 1105h, 1125h
        xianshi1 1205h, instru3, 0700h, 1205h, 1225h
        xianshi1 1305h, instru4, 0700h, 1305h, 1325h
        
        xianshi 0000h, bd1      ;��ʾ������ַ�
        xianshi 0100h, bd1
        xianshi 0200h, bd1
        xianshi 0300h, bd2
        xianshi 0402h, bd0
        xianshi 0426h, bd0
        xianshi 0502h, bd0
        xianshi 0526h, bd0
        xianshi 0602h, bd0
        xianshi 0626h, bd0
        xianshi 0702h, bd0
        xianshi 0726h, bd0
        xianshi 0802h, bd0 
        xianshi 0826h, bd0
        xianshi 0902h, bd0 
        xianshi 0926h, bd0
        xianshi 0a00h, bd2
        xianshi 0b00h, bd1
        xianshi 0c00h, bd1
        xianshi 0d00h, bd1    
        xianshi 0e00h, bd3
        xianshi 0f02h, bd0
        xianshi 0f26h, bd0
        xianshi 1002h, bd0
        xianshi 1026h, bd0
        xianshi 1102h, bd0
        xianshi 1126h, bd0
        xianshi 1202h, bd0
        xianshi 1226h, bd0
        xianshi 1302h, bd0 
        xianshi 1326h, bd0
        xianshi 1402h, bd0
        xianshi 1426h, bd0
        xianshi 1500h, bd3
        
        xianshi1 0b3ah, shi1, 0500h, 0b3ah, 0b5fh      ;��ʾӢ��ʫ�ַ�������ͬ��
        xianshi1 0d2fh, shi2, 0500h, 0d2fh, 0d5fh      ;����ɫΪ��ɫ��ǰ��ɫΪ��ɫ
        xianshi1 0f39h, shi3, 0500h, 0f39h, 0f5fh
        xianshi1 1234h, shi4, 0500h, 1234h, 125fh  
        
        
        
    begin1:
        cmp zifu, 'f'         ;��zifu������ֵΪf���������
        je finish

        call printdate        ;��ӡ����ʱ���붯̬����
        call printtime 
        call printxx1
        call printxx2 
        call printxx3
        call printxx4
        call printxx5 
        call printxx6
        call printxx7
        call printxx8 
        call printxx9 
        
    shuru:
        mov ah, 0bh        ;����0b�Ź��ܲ�ѯ�Ƿ��м�������
        int 21h
        cmp al, 00h        ;���޼���������alΪ0����ת������жϣ����ж���һ��������ָ����ʲô
        je panduan
        mov ah, 00h        ;�ж�������ַ���ʲô
        int 16h
        mov zifu, al
        jmp panduan        ;��ת������жϣ��жϱ��������ַ���ʲô

    kaishi:                
        call clock         ;���ü�ʱ��������
        jmp next111 
               
    panduan:
        cmp zifu,'s'      ;���ַ�Ϊs��b����ת��kaishi���ü�������������Ϊ�ڼ��������������Ѿ�д�˵��ַ�����Ϊs��Ϊb������������clock�ӳ����б����ɶ�Ӧ����
        je kaishi 
        cmp zifu,'b'
        je kaishi 
        cmp zifu, 'r'     ;���ַ�Ϊr����м�ʱ�����ʼ��
        call initial
        
    next111:
        mov ah, 2ch        ;ȡ���ڵ�ʱ��
        int 21h
        cmp dh, second     ;�����ڵ������뵱ǰ�ڴ��������Ƚ�
        jnz begin1         ;����������¿�ʼ
        jmp next111        ;���������Ƚ�
        
        mov ax, 0200h      ;���ù��λ��
        mov bx, 0000h
        mov cx, 0000h 
        mov dx, 1230h
        int 10h
                
    finish:                  ;����ָ��
        mov ax, 0600h        ;����
        mov bx, 0754h
        mov cx, 0000h
        mov dx, 2479h
        int 10h
        
        mov ax, 0200h        ;���ù��λ��
        mov bx, 0000h
        mov cx, 0000h
        mov dx, 0001h
        int 10h 
        
        mov ah, 4ch
        int 21h
code ends                    ;����

end start 
