data segment
    data0 db 'TODAY Is '             ;日期所需变量
    data1 db 4 dup(0),'/'
    data2 db 2 dup(0),'/'
    data3 db 2 dup(0),10,13,'$'
    year dw 0
    month db 0
    day db 0
    
    time0 db 'The Time Is '           ;时间所需变量
    time1 db 2 dup(0),':'
    time2 db 2 dup(0),':'
    time3 db 2 dup(0),10,13,'$'
    hour db 0
    minute db 0                
    second db 0 
    
    watch0 db 'The Time-Consuming Is '      ;计时所需变量
    watch1 db 2 dup(0),':'
    watch2 db 2 dup(0),':'
    watch3 db 2 dup(0),'$' 
    cnthour db 0
    cntminute db 0
    cntsecond db 0
    
    jishi db 'The time-consuming is 00:00:00 $ '      ;文字说明所需变量
    student db 'Name: Du Wenli $'
    number db 'Number: 2015211756 $'
    instru1 db 'Press B To Begin Timer Function$'
    instru2 db 'Press F To Finish The Program$'    
    instru3 db 'Press S To Stop The Program$'
    instru4 db 'Press R To Restart The Program$'
    zifu db 0 
    
    bd0 db '*$'                                          ;板子形状所需变量
    bd1 db '              * *       * *$'  
    bd2 db '  * * * * * * * * * * * * * * * * * * * $'
    bd3 db '  * * * * * * * * * * * * * * * * * * * $'  
    
    shi1 db 'My wishes come true $'                     ;英文诗所需变量
    shi2 db 'When I catch the meteor shower $'
    shi3 db 'In my hands with you $'
    shi4 db 'Wish you have a good day! $'  
        
    hang1 db 0                          ;掉落星星所需变量
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
    
    toasc proc          ;转换asc码子程序 将要显示的数字转换为双位asc码
        mov di, 10 
        cmp ax, 10      ;若取出的数小于十则单独处理
        jl next1
    next:               
        xor dx, dx      ;被除数高十六位在dx中
        div di          ;di为除数10，余数在dx中
        add dx, '0'     ;余数转化ASCII码
        dec bx
        mov [bx], dl
        or ax, ax       ;判断商是否为零
        jnz next 
        jmp next2 
    next1:
        add al, 30h     ;若AX<10,则先转换个位
        dec bx
        mov [bx], al
        mov al,'0'      ;十位置0
        dec bx
        mov [bx], al
    next2:
        ret
    toasc endp
    
    printdate proc           ;显示日期子程序
        mov ax, 0200h        ;设置光标位置在（05,0b）处
        mov bx, 0000h
        mov cx, 0000h    
        mov dx, 050bh
        int 10h 
        
        mov ax, 0600h   ;设背景色为黑色，前景色为灰色，区域为（05,0b）到（05,23）
        mov bx, 0700h
        mov cx, 050bh
        mov dx, 0523h
        int 10h
        
        mov ah, 2ah     ;取日期
        int 21h
        mov word ptr year, cx     ;将取到的年月日存入内存中
        mov byte ptr month, dh
        mov byte ptr day, dl  
    
        mov bx, offset data1+4    ;年份转换为asc码
        xor ax, ax                 
        mov ax, word ptr year
        call toasc    
    
        mov bx, offset data2+2    ;月份转换为asc码
        xor ax, ax 
        mov al, byte ptr month
        call toasc
    
        mov bx, offset data3+2    ;日期转换为asc码
        xor ax, ax
        mov al, byte ptr day
        call toasc 
    
        mov dx, offset data0      ;显示 年月日
        mov ah, 09
        int 21h
        ret
    printdate endp   
    
    printtime proc                ;显示时间子程序
        mov ax, 0200h     ;设置光标位置
        mov bx, 0000h
        mov cx, 0000h      
        mov dx, 060bh
        int 10h      
        
        mov ax, 0600h     ;设背景色黑色，前景色灰色
        mov bx, 0700h
        mov cx, 060bh
        mov dx, 0623h
        int 10h
        
        mov ah, 2ch              ;取时间
        int 21h
        mov byte ptr hour, ch
        mov byte ptr minute, cl
        mov byte ptr second, dh 
       
        mov bx, offset time1+2   ;小时转换
        xor ax, ax
        mov al, byte ptr hour
        call toasc    
        
        mov bx, offset time2+2   ;分钟转换
        xor ax, ax
        mov al, byte ptr minute   
        call toasc
        
        mov bx, offset time3+2    ;秒转换
        xor ax, ax
        mov al, byte ptr second
        call toasc
        
        mov dx, offset time0      ;显示
        mov ah, 09h
        int 21h
        ret
    printtime endp
    
    clock proc            ;计时功能子程序
        mov ax, 0200h      ;设置光标位置
        mov bx, 0000h
        mov cx, 0000h
        mov dx, 0805h
        int 10h         
        
        mov ax, 0600h       ;设背景色黑色，前景色灰色
        mov bx, 0700h
        mov cx, 0805h
        mov dx, 0825h
        int 10h
        
        cmp zifu,'s'       ;设置进位，首先看zifu变量里是否是s，若是则时分秒不再进行加减，若不是则开始计时
        je next4
        inc cntsecond
        cmp cntsecond, 60
        jnz next4
        mov cntsecond, 0
        inc cntminute
        cmp cntminute, 60
        jnz next4
        inc cnthour  
       
    next4:                         ;显示计时
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
    
    initial proc             ;计时器初始化子程序
        mov ax, 0200h
        mov bx, 0000h
        mov cx, 0000h
        mov dx, 0805h
        int 10h    
        
        mov ax, 0600h          ;设背景色黑色，前景色灰色
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
    
    xianshi macro p, q        ;显示提示板的宏
        mov ax, 0200h         ;设置光标位置为p
        mov bx, 0000h
        mov cx, 0000hH
        mov dx, p
        int 10h
        
        mov dx, offset q      ;将要打印的字符首地址传入dx
        mov ah, 09h
        int 21h               ;调用dos功能打印字符
    endm    
   
    xianshi1 macro p, q, cor, m, n       ;显示其他颜色字串的宏
        mov ax, 0200h          ;设置光标位置为p
        mov bx, 0000h
        mov cx, 0000h
        mov dx, p 
        int 10h

        mov ax, 0600h         ;设置背景色前景色，范围为从m到n
        mov bx, cor
        mov cx, m
        mov dx, n
        int 10h
                
        mov dx, offset q      ;将要打印的字符首地址传入dx
        mov ah, 09h 
        int 21h
    endm    
    
    printxx1 proc              ;打印星星子程序1
        mov ax, 0600h          ;设置背景色黑色，前景色黄色
        mov bx, 0e00h
        mov cx, 002ch
        mov dx, 092ch
        int 10h
        
        mov ax, 0200h          ;设置开始显示的坐标为第hang1行，第2ch列
        mov bx, 0000h
        mov cx, 0000h
        mov dh, hang1
        mov dl, 2ch
        int 10h
        
        inc hang1              ;行数加一
        mov dx, offset xx      ;在当前位置显示星星字符
        mov ah, 09h
        int 21h
        cmp hang1, 0ah         ;当当前行数等于0ah时，重置行数为0，否则结束
        je chongzhi1
        jmp jieshu1
    
    chongzhi1:                 ;重置行数
        mov hang1, 0
    jieshu1:
        ret
    printxx1 endp     
        
    printxx2 proc              ;显示星星子程序2 同上
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
    
    printxx3 proc             ;显示星星子程序3 同上
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
    
    printxx4 proc              ;显示星星子程序4 同上
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
    
    printxx5 proc              ;显示星星子程序5 同上
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

    printxx6 proc              ;显示星星子程序6 同上
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
    
    printxx7 proc              ;显示星星子程序7 同上
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
    
    printxx8 proc              ;显示星星子程序8 同上
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
    
    printxx9 proc              ;显示星星子程序9 同上
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
                
    begin:                   ;主程序部分
        mov ax, data
        mov ds, ax    
        
        mov ax, 0600h        ;清屏
        mov bx, 0754h
        mov cx, 0000h
        mov dx, 2479h
        int 10h  
        
        mov ax, 0600h      ;设置背景颜色为黑色，前景颜色为青色，范围为（0,0）到（2fh，4fh）
        mov bx, 0300h
        mov cx, 0000h
        mov dx, 2f4fh
        int 10h
        
        xianshi1 1640h, student, 0700h, 1640h, 165fh   ;显示字符串，参数依次为光标位置，字串首地址，背景色前景色设置，以及范围
        xianshi1 173ch, number, 0700h, 173ch, 175fh    ;都是背景色为黑色，前景色为灰色
        xianshi1 1005h, instru1, 0700h, 1005h, 1025h
        xianshi1 1105h, instru2, 0700h, 1105h, 1125h
        xianshi1 1205h, instru3, 0700h, 1205h, 1225h
        xianshi1 1305h, instru4, 0700h, 1305h, 1325h
        
        xianshi 0000h, bd1      ;显示公告板字符
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
        
        xianshi1 0b3ah, shi1, 0500h, 0b3ah, 0b5fh      ;显示英文诗字符，参数同上
        xianshi1 0d2fh, shi2, 0500h, 0d2fh, 0d5fh      ;背景色为黑色，前景色为紫色
        xianshi1 0f39h, shi3, 0500h, 0f39h, 0f5fh
        xianshi1 1234h, shi4, 0500h, 1234h, 125fh  
        
        
        
    begin1:
        cmp zifu, 'f'         ;若zifu变量的值为f，程序结束
        je finish

        call printdate        ;打印日期时间与动态星星
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
        mov ah, 0bh        ;调用0b号功能查询是否有键盘输入
        int 21h
        cmp al, 00h        ;若无键盘输入则al为0，跳转至标号判断，即判断上一个按键的指令是什么
        je panduan
        mov ah, 00h        ;判断输入的字符是什么
        int 16h
        mov zifu, al
        jmp panduan        ;跳转至标号判断，判断本次输入字符是什么

    kaishi:                
        call clock         ;调用计时函数程序
        jmp next111 
               
    panduan:
        cmp zifu,'s'      ;若字符为s或b都跳转到kaishi调用计数函数程序，因为在计数函数程序中已经写了当字符变量为s或为b的情况，因此在clock子程序中便可完成对应功能
        je kaishi 
        cmp zifu,'b'
        je kaishi 
        cmp zifu, 'r'     ;若字符为r则进行计时程序初始化
        call initial
        
    next111:
        mov ah, 2ch        ;取现在的时间
        int 21h
        cmp dh, second     ;将现在的秒数与当前内存中秒数比较
        jnz begin1         ;不相等则重新开始
        jmp next111        ;相等则继续比较
        
        mov ax, 0200h      ;设置光标位置
        mov bx, 0000h
        mov cx, 0000h 
        mov dx, 1230h
        int 10h
                
    finish:                  ;结束指令
        mov ax, 0600h        ;清屏
        mov bx, 0754h
        mov cx, 0000h
        mov dx, 2479h
        int 10h
        
        mov ax, 0200h        ;设置光标位置
        mov bx, 0000h
        mov cx, 0000h
        mov dx, 0001h
        int 10h 
        
        mov ah, 4ch
        int 21h
code ends                    ;结束

end start 
