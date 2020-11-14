;程序名称：接球游戏                                                                  ;
;作者：周涌                                                                          ;
;时间：2010年6月22日                                                               ;
;注意：本程序中的延时子程序delay 和delay_speed 在不同的机型上延时的效果有可能不同， ; 
;      延时效果不佳时，需要对延时的长度做调整（只需要更改相应的延时程序中参数的值） ;
;      本程序在有的系统中可能会出现“does support fullscreen mode”的问题而不能运行，;
;      但在学院机房的xp系统中可正常运行                                              ;
;游戏简介：小球在框内反弹，小球运动到最下面时能被可左右移动的小条挡住，玩家就可得1分 ; 
;          没有接住小球，游戏就失败。游戏得分到9分后清零，并且速度等级加1，小球的运 ;
;           动速度就会加快。当速度等级到达6，且分数到9，玩家就赢得游戏的胜利。       ;
;                                                                                    ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;*************************************************************************************
data segment; 在这里定义的变量统一的加下划线前缀
    _f_posx   dw 101;   
    _f_posy   dw 1;               frame(外框)的左上角在屏幕中xy坐标初始化为（1,1）
    _f_width dw 100;             frame 的宽度初始化为100
    _f_height dw 150;             frame 的高度150
    _f_border_color db 2; 
    _bar_color     db 1;           小条的颜色值 (0对应的是背景颜色，1对应的是绿色，2对应的是红色，3对应的是暗红色)
    _speedstr db "speed:$"
    _scorestr db "score:$"
    _startstr db "start:t$"
    _leftstr   db"left :s$"
    _rightstr db "right:f$"
    _exitstr db "exit :q$"
    _bar_posx    dw 102 ;指定小条的左上角点的x坐标值是102，而y坐标值是固定的132，小条的x坐标变动范围是[102,160]
    _speed    db   31h            ;小球的移动的初始速度是1,'1'的ascii码值是31h
    _score    db   30h              ;游戏的初始得分是0 '0'的ascii码值是30h
    _gameoverstr db   "GAME OVER$"
    _gamewinstr1 db   "GOOD JOB!$"       
    _gamewinstr2 db   "YOU WIN!$"
    
    _r_q_str1 db   "q: exit$"
    _r_q_str2 db   "r: restart$"
data ends
stack1 segment   STACK 
              DB        200 DUP(?) 
stack1 ends 
code segment
;************************************************************************************
;*主程序                                                                            *
;************************************************************************************
main proc far
     assume ds:data, cs:code,ss:stack1
start:
     mov ax,data
     mov ds,ax

     mov ah,00       ; int10的0号功能是设置显示方式, 具体的方式参数放在了al中
     mov al,04        ;设置显示方式为320*200 图形4色
     int 10h

     mov ah,0bh      ;int10的0b号功能是只彩色调色板ID，bh中方调色板ID，bL中放和ID配套使用的颜色
     mov bh,00
     mov bl,1
     int 10h
      
     mov ah,0bh
     mov bh,1
     mov bl,2
     int 10h
     
     call draw_frame    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;调用画框函数
     
     mov cx,200
     mov dx,150 
     call draw_ball ;draw_ball的两个参数是cx，dx，通过cx，dx指定要画的小球的左上角的坐标值，
                     ;画出一个长宽为4个像素的小方块
     mov cx,98
     mov dx,150
     call draw_ball


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;下面就来让小球动起来
restart:
    mov cx,149;
    mov dx,2             ;指定小球的初始位置是（149,2）
    mov si,1             ;si 对应cx，di对应dx
    mov di,0             ;0对应自加，1对应自减

    call draw_ball; 
    call draw_bar ;
    call show_speed_score
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
   
    ;;;;;;;;;;;;;;;;;;;;;;;;;等待键盘的输入
begin:
    mov ah,08         ;键盘输入无回显
    int 21h
    cmp al,'q' 
    je endgame ;如果输入的是q就跳到endgame处终止程序
    cmp al,'t'
    je rotate
    jmp begin
endgame:
   mov ah,4ch
   int 21h
rotate:
     
    cmp dx,128
    jne next0 
    ;check_game_fail用来了ax作为返回参数，故在调用前要将ax中的数据保护起来
    ;保护ax中的数据
    push ax              
    call check_game_fail ;子程序check_game_fail，传入的参数是dx和cx，返回的是ax，
                          ;返回ax=0，表明游戏没有失败，就得一分，ax=1表示游戏失败了
    cmp ax,1
    je LAST1
    mov al,_score ; ax！=1的时候，就该加一分了
    inc al ;加一分
    cmp al,3ah ;比‘9’的ascii码值是39h，如果加的分数等于10就将分数清零，且速度等级加1 ,
    jb next0_1;
    mov _score,30h     ;;分数清零
    mov al,_speed
    inc al             ;速度自增1
    cmp al,37h         ;'7'的ascii码值是37h，速度设置的等级是从1到6，包括6，
    je LAST2   ; 如果速度等级超过了6，说明玩家取得了游戏的最终胜利，程序跳转到LAST
    mov _speed,al
    jmp next0_end 
next0_1: 
    mov _score,al
next0_end:   
    ;恢复ax中的数据 
    pop ax
    
next0:    
    call move_ball
    ;call draw_bar
    call show_speed_score ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;显示分数和速度等级
    push si
    push di
    push cx
    push dx
     
    call delay_speed ; 这个子程序的参数就是变量_speed,根据当前_speed的值来确定延时的长短
   
    mov ah,06      ;;;;;;;;;;;;;;;;;;;;;;;了不起的06功能,键盘输入，但是不中断程序
    mov dl,0ffh
    int 21h
    cmp al,'q'    ;如果输入时‘q’就跳到LAST4
    je LAST4
    cmp al,'f'
    jne next1
    call mov_bar_right ;al=='f',就执行一下右移子程序
next1:
    cmp al,'s'
    jne next2
    call mov_bar_left ;al=='s',就执行一下左移子程序
next2:
    ;恢复数据   
    pop dx
    pop cx
    pop di
    pop si
    jmp rotate
      
     
LAST1:
     ;;;;;;;;;;;;;;;;;;;;;;;;;; 显示“GAMEM OVER”
    call output_GameOver;
    jmp LAST3
LAST2:
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;显示“游戏胜利”的提示信息
    call output_GameWin; 
      
LAST3:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 显示提示信息“如果输入r就重新开始游戏，如果输入q就退出程序”
    call output_r_q ;
reinput:   
    mov ah,08         ;键盘输入无回显
    int 21h
    cmp al,'q'        ;如果输入的是‘q’字符就跳转到LAST4 
    je LAST4
    cmp al,'r'
    jne reinput;       不等就要求重新输入“r或q”
;;;;;;;;;;;;;如果输入的是r，那就要重新开始游戏，下面就来将框内的图形擦除掉并将相应变量的值恢复到初始状态
   call clean_ball;
   call clean_bar;
   call clean_words; 擦除方框以内的文字信息
   mov ax,102
   mov _bar_posx,ax ;指定小条的左上角点的x坐标值是102，而y坐标值是固定的132，小条的x坐标变动范围是                                      ;[102,160]
   mov al,31h
   mov _speed,al    ;小球的移动的初始速度是1,'1'的ascii码值是31h
   mov al,30h
   mov _score ,al
   jmp restart

LAST4: 
mov ah,4ch
int 21h 
main endp;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;主程序结束

;************************************************************************************
;*画框的子程序                                                                      *
;************************************************************************************
draw_frame proc near
;;;;;先保护好数据
     push ax
     push bx
     push cx
     push dx
;;;;;下面就开画线了
;;;;;;;;;;;;;;;;;画top_line;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
     mov al,_f_border_color     ;放入颜色值
     mov dx,_f_posy             ;指定像素的行数
     mov cx,_f_posx             ;指定像素所在的列数
top_line:
     mov ah,0ch                 ;int10的画点的功能参数
     mov bh,0                   ;指定页码为0
     int 10h                    ;调用功能画点
     inc cx                     ;cx自增1
     cmp cx,200           
     jle top_line;              ;
;;;;;;;;;;;;;;;;;画down_line;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
     mov al,_f_border_color     ;放入颜色值 
     mov dx,_f_height
     mov cx,_f_posx
down_line:
     mov ah,0ch                 ;int10的画点的功能参数
     mov bh,0                   ;指定页码为0
     int 10h                     ;调用功能画点
     inc cx                     ;cx自增1
     cmp cx,200           ;
     jle down_line; 
;;;;;;;;;;;;;;;;;画left_line;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
     mov al,_f_border_color     ;放入颜色值
     mov dx,_f_posy             ;指定像素的行数
     mov cx,_f_posx             ;指定像素所在的列数
left_line:
     mov ah,0ch                 ;int10的画点的功能参数
     mov bh,0                   ;指定页码为0
     int 10h                    ;调用功能画点
     inc dx                     ;dx自增1
     cmp dx,_f_height          ;_f_height =150px
     jle left_line;        
;;;;;;;;;;;;;;;;;画right_line;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
     
     mov dx,_f_posy
     mov cx,200 
right_line:
     mov ah,0ch                 ;int10的画点的功能参数
     mov bh,0                   ;指定页码为0
     int 10h                     ;调用功能画点
     inc dx                     ;dx自增1
     cmp dx,_f_height             ;
     jle right_line;      
;;;;;;;恢复数据
     pop dx
     pop cx
     pop bx
     pop ax 
     ret
draw_frame endp
;************************************************************************************
;*画小球的子程序,用cx，dx传入小球 左上角的坐标是（cx，dx）                          *
;************************************************************************************

draw_ball proc near
     
     ;mov dx,80;   
     ;mov cx,150;                ; 指定小球的左上角的坐标
     push ax
     push di
     push si
     push dx
     push cx
     push cx
     push cx
     push cx
     push cx
     mov si,dx
     add si,4
     mov di,cx
     add di,4
     
     mov al,_f_border_color     ;放入颜色值
ball_line:
     cmp dx,si
     je ball_line_end
     mov ah,0ch                 ;int10的画点的功能参数
     mov bh,0                   ;指定页码为0
     int 10h                    ;调用功能画点
     inc cx
     cmp cx,di
     jne ball_line
     pop cx 
     inc dx
     jmp ball_line
ball_line_end:
     
     pop cx ;恢复数据
     pop dx ;恢复数据
     pop si
     pop di
     pop ax
     ret
draw_ball endp
;************************************************************************************
;*擦除小球的子程序，                                                                *
;*和画小球的程序几乎一样，只有画图的颜色不一样而已                                  *
;************************************************************************************
clean_ball proc near
     
     ;mov dx,80;   
     ;mov cx,150;                ; 指定小球的左上角的坐标
     push ax
     push di
     push si
     push dx
     push cx
     push cx
     push cx
     push cx
     push cx
     mov si,dx
     add si,4
     mov di,cx
     add di,4
     
     mov al,0      ;放入颜色值0,应该放入背景颜色的值
clean_ball_line:
     cmp dx,si
     je clean_ball_line_end
     mov ah,0ch                 ;int10的画点的功能参数
     mov bh,0                   ;指定页码为0
     int 10h                    ;调用功能画点
     inc cx
     cmp cx,di
     jne clean_ball_line
     pop cx 
     inc dx
     jmp clean_ball_line
clean_ball_line_end:
     
     pop cx ;恢复数据
     pop dx ;恢复数据
     pop si
     pop di
     pop ax
     ret
clean_ball endp


;***************************************************************************************
;*画小条的子程序，                                                                     *
;*参数：cx 。                                                                          *
;*调用这个子程序将画出一个符合下面要求的矩形条：长度是40个像素，高度是4个像素，左上    *
;*角的y坐标值固定为132，左上角x坐标值是_bar_posx中的值。这个程序中要求x坐标的取值属于[102,160]*
;*坐标值由_bar_posx指定，                                                                     *
;***************************************************************************************
draw_bar proc near
     ;保护数据
     push ax
     push di
     push si
     push dx
     push cx
     
     mov cx,_bar_posx;
     push cx
     push cx
     push cx
     push cx
     
     mov dx,132                 ;指定左上角的y坐标值为132
     mov si,dx
     add si,4
     mov di,cx
     add di,40
     
     mov al,_bar_color     ;放入颜色值
bar_line:
     cmp dx,si
     je bar_line_end
     mov ah,0ch                 ;int10的画点的功能参数
     mov bh,0                   ;指定页码为0
     int 10h                    ;调用功能画点
     inc cx
     cmp cx,di
     jne bar_line
     pop cx 
     inc dx
     jmp bar_line
bar_line_end:
     
     ;恢复数据
     pop cx 
     pop dx ;恢复数据
     pop si
     pop di
     pop ax
     ret
draw_bar endp
;************************************************************************************
;*擦除小条的子程序，和上面的draw_bar的唯一区别在于画图的颜色值变成了0,达到擦除的效果*
;************************************************************************************ 
clean_bar proc near
     push ax
     push di
     push si
     push dx
     push cx
     
     mov cx,_bar_posx;
     push cx
     push cx
     push cx
     push cx
     
     mov dx,132                 ;指定左上角的y坐标值为132
     mov si,dx
     add si,4
     mov di,cx
     add di,40
     
     mov al,0    ;放入颜色值
clean_bar_line:
     cmp dx,si
     je clean_bar_line_end
     mov ah,0ch                 ;int10的画点的功能参数
     mov bh,0                   ;指定页码为0
     int 10h                    ;调用功能画点
     inc cx
     cmp cx,di
     jne clean_bar_line
     pop cx 
     inc dx
     jmp clean_bar_line
clean_bar_line_end:
     
     pop cx ;恢复数据
     pop dx ;恢复数据
     pop si
     pop di
     pop ax
     ret
clean_bar endp
;************************************************************************************
;*将小条右移的子程序                                                                *
;************************************************************************************
mov_bar_right proc near
     ;保护数据
     push ax

     mov ax,_bar_posx
     cmp ax,160           ;小条的左上角的x坐标举止范围是[102,160]
     jae mov_bar_right_end; 如果小条的位置已经在最右端了，就不用在重画了，直接跳到子程序结尾
     call clean_bar;    先要擦除原图
     add ax,2   ;小条每次移动2个像素，
     mov _bar_posx,ax
     
     call draw_bar ;重画小条
     
     ;恢复数据
mov_bar_right_end:
     pop ax
     ret
mov_bar_right endp
;************************************************************************************
;*将小条左移的子程序                                                                *
;************************************************************************************
mov_bar_left proc near
     ;保护数据
     push ax

     mov ax,_bar_posx
     cmp ax,102            ;小条的左上角的x坐标举止范围是[102,160]
     jbe mov_bar_left_end; 如果小条的位置已经在最左端了，就不用在重画了，直接跳到子程序结尾
     call clean_bar;    先要擦除原图
     sub ax,2
     mov _bar_posx,ax
     
     call draw_bar ;重画小条
     
     ;恢复数据
mov_bar_left_end:
     pop ax
     ret
mov_bar_left endp
;************************************************************************************
;*延时子程序1,被下面的那个子程序调用的                                              *
;************************************************************************************

delay proc near
push cx
mov cx,60000
waste0: loop waste0
mov cx,60000
waste1: loop waste1
mov cx,60000
waste2: loop waste2
mov cx,60000
waste3: loop waste3
pop cx

ret
delay endp
;************************************************************************************
;*延时程序2，根具当前的speed的值来确定延时的长短                                    *
;*在不用的不同的速度的情况下，调用的delay子程序的次数不同；                         *
;*速度等级从1到6一次对应调用delay的次数依次为60次、50次、40次、30次、20次、10次     *
;************************************************************************************
delay_speed proc near ;
   ;保护数据
   push ax
   push bx
   push cx

   xor cx,cx
   xor ax,ax
   xor bx,bx
   mov ax,37h; 字符'7'的ASCII码值是37h
   mov bl,_speed ;注意：_speed中存的的数字字符的ascii值
   sub ax,bx
   mov bx,10
   mul ax ;让ax中的值乘以10
   mov cx,ax
waste11:
   call delay
   loop waste11
   ;恢复数据
   pop cx
   pop bx
   pop ax
   ret
delay_speed endp

;************************************************************************************
;*move_ball子程序 移动小球的位置                                                    *
;传入的参数是cx dx si di，返回的参数也是cx，dx，si，di                              *
;cx,dx 是小球的当前坐标，si为标志cx或自增或自减 di标志dx是该自加或该自减          *
;************************************************************************************
move_ball proc near
     call clean_ball     ;首先得要擦除原来小球的图像
     cmp si,0 ;如果si==0，则要重画的小球的x坐标为cx++，如果si！=0，则要重画的小球的x坐标为cx--
     je x_jia
     dec cx
     jmp x_end
x_jia:
     inc cx
x_end:    
     cmp di,0 ;如果di==0，则要重画的小球的y坐标为dx++，如果di！=0，则要重画的小球的y坐标为dx--      
     je y_jia
     dec dx
     jmp y_end
y_jia:
     inc dx
y_end: 

     call draw_ball
;;;;;;;;;;;;;画完图后根据当前的坐标来更新下si di的值
     cmp cx,102 
     je si_0             ;如果cx==102了，说小球已经到了左边界，x坐标值就该自增了，si==0，                  
     cmp cx,196          ;就是所接下来画的小球的x坐标是cx++
     je si_1
     jmp si_end; si不需要变换
si_0:
    mov si,0
    jmp si_end 
si_1:
    mov si,1
si_end:

     cmp dx,2
     je di_0             ;如果dx==2了，说小球已经到了上边界，y坐标值就该自增了，di==0，
     cmp dx,128          ;就是所接下来画的小球的y坐标是dx++
     je di_1             ;如果dx==129了，说小球已经到了下边界，y坐标值就该自增了，di==1，
                         ;就是所接下来画的小球的y坐标是dx--
     jmp di_end ; di不需要变换
di_0:
    mov di,0 
    jmp di_end
di_1:
    mov di,1
di_end:
    ret
move_ball endp 
;************************************************************************************
;*显示分数和速度值的程序                                                            *
;************************************************************************************
show_speed_score proc near
    ;保护数据
    push ax
    push bx
    push dx
    
    mov ah, 2
    mov bh,0
    mov dl,3; 指定列数
    mov dh,1   ;指定行数
    int 10h;;;置光标的位置
    mov ah,09h
    lea dx,_speedstr
    int 21h
    
    mov ah, 2
    mov bh,0
    mov dl,9; 指定列数
    mov dh,1   ;指定行数
    int 10h;;;置光标的位置
    mov ah,02h;显示单个字符
    mov dl,_speed;                  ;_speed中存的是速度值的ascii值
    int 21h
    
    mov ah, 2
    mov bh,0
    mov dl,3; 指定列数
    mov dh,2   ;指定行数
    int 10h;;;置光标的位置
    mov ah,09h
    lea dx,_scorestr
    int 21h
    
    mov ah, 2
    mov bh,0
    mov dl,9; 指定列数
    mov dh,2   ;指定行数
    int 10h;;;置光标的位置
    mov ah,02h;显示单个字符
    mov dl,_score;                  ;_score中存的是分数的ascii值
    int 21h
    
    mov ah, 2                       ; 显示按键提示信息
    mov bh,0
    mov dl,3; 指定列数
    mov dh,4   ;指定行数
    int 10h;;;置光标的位置
    mov ah,09h
    lea dx,_startstr
    int 21h
    
    mov ah, 2                       ; 显示按键提示信息
    mov bh,0
    mov dl,3; 指定列数
    mov dh,5   ;指定行数
    int 10h;;;置光标的位置
    mov ah,09h
    lea dx,_leftstr
    int 21h
    
    mov ah, 2                       ; 显示按键提示信息
    mov bh,0
    mov dl,3; 指定列数
    mov dh,6   ;指定行数
    int 10h;;;置光标的位置
    mov ah,09h
    lea dx,_rightstr
    int 21h
    
    mov ah, 2                       ; 显示按键提示信息
    mov bh,0
    mov dl,3; 指定列数
    mov dh,7   ;指定行数
    int 10h;;;置光标的位置
    mov ah,09h
    lea dx,_exitstr
    int 21h
   ; 恢复数据
    pop dx
    pop bx
    pop ax
    ret
show_speed_score endp   
;************************************************************************************
;*显示“GAME OVER ”子程序                                                          *
;************************************************************************************ 
output_GameOver proc near
    push ax
    push bx
    push dx
    
    mov ah, 2
    mov bh,0
    mov dl,14; 指定列数
    mov dh,7   ;指定行数
    int 10h    ;;;置光标的位置
    mov ah,09h
    lea dx,_gameoverstr
    int 21h
     
    pop dx
    pop bx
    pop ax
    ret
output_GameOver endp 
;************************************************************************************
;*显示“游戏胜利”子程序                                                            *
;************************************************************************************
output_GameWin proc near
    push ax
    push bx
    push dx
    
    mov ah, 2
    mov bh,0
    mov dl,14; 指定列数
    mov dh,7   ;指定行数
    int 10h    ;;;置光标的位置
    mov ah,09h
    lea dx,_gamewinstr1
    int 21h
    
    mov ah, 2
    mov bh,0
    mov dl,14; 指定列数
    mov dh,8   ;指定行数
    int 10h    ;;;置光标的位置
    mov ah,09h
    lea dx,_gamewinstr2
    int 21h
    
     
    pop dx
    pop bx
    pop ax
    ret
output_GameWin endp 
;************************************************************************************
;* 显示“是退出还是重新游戏”的提示信息 的子程序                                    *
;************************************************************************************
output_r_q proc near
    push ax
    push bx
    push dx
    
    mov ah, 2
    mov bh,0
    mov dl,14; 指定列数
    mov dh,9   ;指定行数
    int 10h    ;;;置光标的位置
    mov ah,09h
    lea dx,_r_q_str1
    int 21h
    
    mov ah, 2
    mov bh,0
    mov dl,14; 指定列数
    mov dh,10   ;指定行数
    int 10h    ;;;置光标的位置
    mov ah,09h
    lea dx,_r_q_str2
    int 21h
    
     
    pop dx
    pop bx
    pop ax
    ret
output_r_q endp 
;************************************************************************************
;*检查游戏是否失败的子程序，                                                        *
;传入的参数：dx是小球的y坐标值，还用到了定义的变量 _bar_posx（小条左上角的x坐标值） *
;返回的参数： ax 如果游戏失败ax赋值1，否则ax赋值0                                  *
; 这个子程序就是检查一下，在小球的运动在最低端时，小球和小条是否可以同时被某一垂直线*
;同时穿过，如果可以，则ax=1，如果不可以ax=0                                         *
;注：当（cx）+3>=_bar_posx且（cx）<=_bar_posx+39时，游戏就还没失败,否则就失败了     *
;************************************************************************************
check_game_fail proc near
     ;保护数据
     push cx
     push bx
     
     mov ax,0        ;游戏没有失败，ax中就存0
     cmp dx, 128;    小球的左上角的y坐标值是128时才需要检查
     jne check_game_fail_end; 不等就直接跳到结尾处
     add cx,3
     cmp cx,_bar_posx
     jb check_game_fail_1; cx=cx+3,若cx<_bar_pos，则游戏失败
     sub cx,3
     mov bx,_bar_posx
     add bx,39
     cmp cx,bx
     ja check_game_fail_1;（cx）>_bar_posx+39 时游戏失败
     jmp check_game_fail_end ; 运行到这一句说明游戏没有失败 
     
check_game_fail_1: 
    mov ax,1 ;游戏失败，就给ax赋值1
     
check_game_fail_end:
    pop bx 
    pop cx 
    ret
check_game_fail endp
;************************************************************************************
;* 清除方框内的内容子程序                                                           *
;************************************************************************************
clean_words proc near
     ;保护数据 
     push ax
     push di
     push si
     push dx
     push cx

     mov cx,110
     mov dx,55                ;指定左上角的坐标是（，）
     mov di,cx
     add di,80                ;矩形的宽度是80px
     mov si,dx
     add si,33                ;矩形的高度是33px
     
     mov al,0    ;放入颜色值
clean_words_line:
     cmp dx,si
     je clean_words_line_end
     mov ah,0ch                 ;int10的画点的功能参数
     mov bh,0                   ;指定页码为0
     int 10h                    ;调用功能画点
     inc cx
     cmp cx,di
     jne clean_words_line
     mov cx,110 
     inc dx
     jmp clean_words_line
clean_words_line_end:
     
     pop cx ;恢复数据
     pop dx ;恢复数据
     pop si
     pop di
     pop ax
     ret
clean_words endp 
code ends
end start