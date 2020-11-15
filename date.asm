data segment 'data'
str1 db 25 dup (20h),'Today is    '
Str_month db 2 dup(0),'/'
Str_day db 2 dup(0),'/'
Str_year db 4 dup(0),0dh,0ah
str2 db 25 dup (20h),'Time  is     '
Str_hour db 2 dup(0),':'
Str_minute db 2 dup(0),':'
Str_second db 2 dup(0),20h,0dh,0ah,0dh,0ah
Str_time db  33 dup (20h),30h,30h,':',30h,30h,':',30h,30h,0dh,0ah,'$'
Str_reset db 33 dup (20h),30h,30h,3ah,30h,30h,3ah,30h,30h,0dh,0ah,24h
introduce db 0dh,0ah,0dh,0ah,25 dup (20h),'Press the c to start countting',0dh,0ah,25 dup (20h),'Press the r to reset  counting',0dh,0ah,25 dup (20h),'Press the e to end the procedure',0dh,0ah,25 dup (20h),'Press the s to stop the count',0dh,0ah,0dh,0ah,0dh,0ah,0dh,0ah,0dh,0ah ;介绍关于如何使用按键的说明
str_information db 55 dup(20h),'class: 2013211405',0dh,0ah,55 dup(20h),'num:   2013211873',0dh,0ah,55 dup(20h),'name:  Wu Shiguang','$'
month db 0  ;月值
day   db 0
year  dw 0
hour  db 0
minute db 0
second db 0   ;当前时刻的秒数
secondo db 0  ;计时时，保存的前一时刻的秒数值
countend db 0 ;是否计时的初值设置
bupt db 8 dup (20h),32 dup (01h,20h),0dh,0ah,
         35 dup (20h),'Welcome!',0dh,0ah,18 dup (20h),'The procedure is use to display the current time,',0dh,0ah, 
          25 dup (20h),'And it can count the time.',0dh,0ah,
          8 dup (20h),32 dup (01h,20h),0dh,0ah,'$'

data ends
stack  segment stack 'stack'
db 256 dup(?)
stack ends
code  segment public 'code' 
      assume cs:code,ds:data,ss:stack,es:data
      org 100h
start:  jmp begin
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
;字程序，将二进制数转换成ASCII码
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
num2asc proc     ;子程序，将二进制数转换成ASCII码
       mov si,10
next:  xor dx,dx
       div si
       add dx,'0'
       dec bx
       mov [bx],dl
       or ax,ax
       jnz next
       ret
num2asc endp
num2asc1     proc  near;将时间与日期转换成ASCII码子程序2
            mov cx,2
            mov si,10
next1:       xor dx,dx
            div si
            add dx,'0'
            dec bx
            mov [bx],dl
            or ax,ax            
            loop next1
            ret
num2asc1  endp      
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
;宏定义，判断计时的进制数是否进位
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
countcmp   macro value,str_value     ;value ：为时分秒的进制数，str_value :为进位数的值
       cmp byte ptr [bx],value       ;比较时分秒是否满足进数值   个位的时
       jne display                   ;如果不满足，直接输出
       mov byte ptr [bx],30h         ;如果满足，则置0
       mov bx,dx                     ;取进位值
       inc byte ptr [bx]             ;高位加一
       endm                          ;结束宏定义
;主程序
begin:  ;>>>>>>>>>>>>>>>>>>     
        ;清屏程序
        ;>>>>>>>>>>>>>>>>>>
       mov ax,data   ;整个窗口为空白
       mov ds,ax     ;窗口左上角的行位置
       mov es,ax     ;窗口左上角的列位置
       mov al,0      ;整个窗口为空白
       mov ch,0      ;窗口左上角的行位置
       mov cl,0      ;窗口左上角的列位置
       mov dh,24     ;窗口右下角的行位置
       mov dl,79     ;窗口右下角的列位置
       mov bh,75h    ;背景色为浅灰，前景色是降色
       mov ah,06h    ;中断调用
       int 10h

        
forever:
        mov ah,1                    ; 置光标类型，不显示光标
        mov ch,20h
        int 10h

        mov ax,0200h              ;设置光标在第四行第16列
        mov bx,0000h
        mov cx,0000h
        mov dx,0200h
        int 10h   
        ;>>>>>>>>>>>>>>>>>>     
        ;读取日期值程序
        ;>>>>>>>>>>>>>>>>>>
       mov ah,2ah                 ;调用日期功能号，读取当前日期
       int 21h
       mov byte ptr month,dh       ;保存月份
       mov byte ptr day,dl         ;保存日
       mov word ptr year,cx        ;保存年
       mov bx,offset Str_month + 2 ;取月份字符串末尾地址
       xor ax,ax                   ;ax清零
       mov al,byte ptr month       ;取月份
       call num2asc                ;调用子程序把月份二进制数转换成ascii码

       mov bx,offset Str_day + 2   ;取日期字符串末尾地址
       xor ax,ax                   ;AX清零
       mov al,byte ptr day         ;取月份
       call num2asc                ;调用子程序把日期二进制数转换成ascii码

       mov bx,offset Str_year + 4  ;取年份字符串末尾地址
       mov ax,word ptr year        ;取月份
       call num2asc                ;调用子程序把日期二进制数转换成ascii码

       

       ;>>>>>>>>>>>>>>>>>>     
       ;读取时间值程序
       ;>>>>>>>>>>>>>>>>>>
       mov ah,2ch                   ;调用时间功能号，读取当前时间
       int 21h
       mov byte ptr hour,ch         ;保存小时
       mov byte ptr minute,cl       ;保存分
       mov byte ptr second,dh       ;保存秒数

       mov bx,offset Str_hour + 2   ;取小时字符串末尾地址
       xor ax,ax                    ;AX清零
       mov al,byte ptr hour         ;取小时
       call num2asc1                 ;调用子程序把小时二进制数转换成ascii码

       mov bx,offset Str_minute + 2 ;取分字符串末尾地址
       xor ax,ax                    ;AX清零
       mov al,byte ptr minute       ;取分钟
       call num2asc1                 ;调用子程序把分钟二进制数转换成ascii码

       mov bx,offset Str_second + 2 ;取月份字符串末尾地址
       xor ax,ax                    ;AX清零
       mov al,byte ptr second       ;取秒数
       call num2asc1                 ;调用子程序把秒数二进制数转换成ascii码

       cmp countend,63h             ;与计数键c的值做比较
       jz count                     ;当有c按下时，则跳到计数程序
  
       
display:mov dx,offset bupt          ;取bupt字符串的首地址
       mov ah,09h                   ;调用显示中断，显示字符串
       int 21h
       mov dx,offset str1           ;取str1字符串的首地址
       mov ah,09h                   ;调用显示中断，显示字符串
       int 21h
       mov dx,offset introduce      ;取introdence字符串的首地址
       mov ah,09h                   ;调用显示中断，显示字符串
       int 21h
       ;>>>>>>>>>>>>>>>>>>>
       ;中断判断
       ;>>>>>>>>>>>>>>>>>>>
       mov ah,1h                    ;判断是否有按键输入，ZF=0时，键盘有输入，ZF=1时无输入
       int 16h
       jz forever
       mov ah,0h                    ;读取按键的值
       int 16h
       cmp al,65h                   ;判断是否按下退出键e
       jnz r1                       ;如果没有则跳到判断是否按下退出键e
       mov ah,4ch                   ;如果按下则执行退出程序
       int 21h

    r1:cmp al,72h                   ;判断是否按下退出键r
       jnz c1                       ;如果没有则跳到判断是否按下计时键c
       mov di,offset Str_time       ;如果按下则执行复位键r，复位定时时间
       mov si,offset Str_reset
       mov cx,44
   rep movsb
       mov countend,0h
       jmp forever
       
    c1:cmp al,63h                   ;判断是否按下退出键c
       jnz s1                       ;如果没有则跳到判断是否按下暂停键s
       mov  word ptr countend,63h   ;如果按下则执行计数键c，进行计时
       jmp forever                 

    s1:cmp al,73h                   ;判断是否按下暂停键s
       jnz forever
       mov  word ptr countend,0h    ;如果按下计时键则停止计时
       jmp forever

      ;>>>>>>>>>>>>>>>>>>
      ;计时程序
      ;>>>>>>>>>>>>>>>>>>
count: mov bx,offset Str_time + 40   ;计时的设置
       mov dl,byte ptr second        ;取当前秒数
       cmp secondo,dl                ;secondo为前一个时刻的秒数，与当前秒数作比较
       mov secondo,dl                ;将当前的秒数赋给secondo
       jz display                    ;判断俩个值是否相等，如果俩个值相等，表示还未经过一秒，则直接显示
       inc byte ptr [bx]             ;如果俩个值不等的情况下，使计时的秒数加一

       mov dx,offset Str_time + 39   ;取秒数的十位
       countcmp 3ah,dx      ;用宏定义，判断秒数的个位是否等于10，如果等于10，则置秒数的个位为0，并使秒数的十位加一

       mov dx,offset Str_time + 37   ;取分钟的个位
       countcmp 36h,dx      ;用宏定义，判断秒数的十位是否等于6，如果等于6，则置秒数的十位为0，并使分钟的个位加一

       mov dx,offset Str_time + 36   ;取分钟的十位
       countcmp 3ah,dx      ;用宏定义，判断分钟的个位是否等于10，如果等于10，则置分钟的个位为0，并使分钟的十位加一


       mov dx,offset Str_time + 35    ;取小时的个位
       countcmp 36h,dx      ;用宏定义，判断分钟的十位是否等于6，如果等于6，则置分钟的十位为0，并使小时的个位加一

       mov dx,offset Str_time + 34     ;取小时的十位
       countcmp 3ah,dx      ;用宏定义，判断小时的个位是否等于10，如果等于10，则置小时的个位为0，并使小时的十位加一
 
       mov dx,word ptr Str_time       ;取小时的个位和十位
       cmp dx,3432h                   ;判断小时值等于24，
       jne display                    ;如果不等，直接显示
       mov byte ptr [bx],30h          ;如果等于，将小时值置0
       mov bx,offset Str_time
       mov byte ptr [bx],30h
       jmp display 

code   ends
       end start