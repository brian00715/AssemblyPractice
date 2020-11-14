DATAS segment ;前280行为数据段
    ;此处输入数据段代码  
    ;这些变量是用来给setarea传递参数，函数十四
    qidianx dw 0 ;起点x
    qidiany dw 0 ;起点y
    zhongdianx dw 10 ;终点x
    zhongdiany dw 3 ;终点y
    color db 10 
    racket_color db 0111b;球拍颜色—白色
    frame_color db 0110b;边框颜色—棕色 
    ball_color db 1110b;球的颜色—黄色
    brick_color1 db 1111b;易碎砖块的颜色—高亮白色
    brick_color2 db 1010b;普通砖块的颜色—浅绿色
    brick_color3 db 0101b;硬质砖块的颜色—品红色
    inmenu_color db 1110b; 内部菜单的颜色—x黄色
    wave_brick_color db 1001b;飘动档板的颜色—浅蓝色 
    ;********************************************************* 
    exitflag dw 1;用来记录玩家什么时候要退出游戏，当为0时退出 
    stopflag dw 0;用于记录什么时候暂停，如果是1则暂停 
    replayflag dw 0;用于记录是否重新开局，1为有效 
    propflag db -1;用来判断当前屏幕中是否有道具，如果没有则为-1，否则为相应的第0到n个道具 
    speedflag dw 0;用来判断是否要加速,如果为1则为加速 
    cmpgameflag db 0;用来记录游戏中的所有砖块是否打完，如果打完，则为1 
    inmenuflag  db 1;这个变量只是在最开始进入画面时用到，为了防止中断打断，因此init中不需要对它初始化，1为有效 
    balldeadflag db 0;判断小球的生命值是不是都打完了，如果为1，那么就意味着小球死光光了 
    barflag db 1;用于记录是第几关，一共有5关 
    bomb_flag db 0;用于显示当接到bomb后的特效，当为0时说明没有特效 
    ;********************************************************** 
    ;一些要显示的字符 
    brick_msg db 'BRICK$' 
    mader_msg db 'MADE BY: XJTUSE$' 
    play_msg db 'Press space to play!$' 
    score_msg db 'Score:$' 
    life_msg db 'Life:$' 
    prop_msg db 'PROP$' 
    none_msg db 'NULL     $' 
    hint_msg1 db '   HINT$' 
    hint_msg2 db '<Esc>:exit $' 
    hint_msg3 db 'Space:pause$' 
    hint_msg4 db '<R>: replay$' 
    ;这些msg是用在道具的提示上的 
    addlife_msg      db 'LIFE     $' ;奖生命
    addscore_msg     db 'SCORE    $' ;奖分数
    speed_up_msg     db 'SPEED UP $' ;球加速
    speed_down_msg   db 'SPEEDDOWN$' ;球减速
    large_racket_msg db 'L RACKET $' ;大球拍
    small_racket_msg db 'S RACKET $' ;小球拍
    bomb_msg         db 'BOMB     $' ;普通炸弹
    bigbomb_msg      db 'SUP BOMB $' ;超级炸弹
     
    stop_msg db 'Press space to continue!$'; 当暂停的时候要调用这个 
    con_msg  db '                        $';继续玩的时候，将之前的那个字体给涂成黑色 
    lose_msg db 'You lose!  Play again?(Y/N)$';当生命值为0时要用到这个msg 
    con1_msg db '                            $';继续玩的时候，将之前的那个字体给涂成黑色 
     
    congratulation_msg db 'Congratulation!!You win!!$' 
    youscore_msg db 'Please enter next $';分数显示 Your score is: $
    playagain_msg db 'Play next level?(Y/N)$' 
    ;*********************************************************  
    ;要记录的数值 
    wave_brick1 dw 15;第一个挡板的最左边的位置 
    wave_brick2 dw 170;第二个挡板的最右边的位置 
    wave_brick1_pos db 1;1为向右移动，记录第一个档板的运动方向 
    wave_brick2_pos db 0;0为向左移动，记录第二个档板的运动方向 
    count db 0;这个变量是用来记录次数的 
    bomb_count db 0;用于炸弹的特效 
    life_num db 3;记录生命值 
    score_num db 0;得分总和不能大于255 
    mouse_last dw 80;用于记录上一次的的鼠标的位置，只记录x轴 
    racket_width dw 30;用于记录球拍的宽度 
    ballx dw 90;用来记录球的左上角的x轴坐标 
    bally dw 183;用来记录球的左上角的y轴坐标 
    brick_num dw 100;用来记录砖块的数量 
    x dw 1;用于记录运动向量 
    y dw -1;用于记录运动向量 
    propx dw 0;这个变量是用来画道具时，储存道具的左上角的x轴信息 
    propy dw 0;这个变量是用来画道具时，储存道具的左上角的y轴信息 
    ;这个是道具的颜色，它们的顺序与下面道具的顺序一一对应 
    prop_color db 0001b ;增加生命的道具
               db 0010b ;增加分数的道具
               db 0011b ;加速的道具
               db 0100b ;减速的道具
               db 1000b ;大球拍的道具
               db 1001b ;小球拍的道具
               db 1010b ;普通炸弹的道具 
               db 1011b ;超级炸弹的道具 
    bomb_color db 1100b ;
    ;*******用来记录砖块的剩余生命值 
    brick_life db 100 dup(0) 
    brick_life_huanyuan1 db 2,2,2,2,4,2,2,2,2,2 ;第一关初始布局
			               db 1,1,4,1,1,4,1,1,1,1 
			               db 1,1,1,4,2,4,2,1,1,1 
			               db 2,1,2,4,1,1,1,2,1,2 
			               db 2,1,2,1,1,1,1,2,1,4 
			               db 1,1,1,2,1,1,4,1,1,4 
			               db 1,4,1,1,1,1,1,1,1,1 
			               db 1,1,1,2,1,2,1,2,1,2 
			               db 1,1,2,1,4,1,1,1,2,1 
			               db 2,1,1,1,1,1,1,1,1,2 
    brick_life_huanyuan2 db 2,2,2,2,2,2,2,2,2,2  ;第二关初始布局
	                      db 1,1,1,1,1,1,1,1,1,1 
	                      db 4,4,4,4,4,4,4,4,4,4 
	                      db 2,2,2,4,1,1,4,2,2,2 
	                      db 1,1,1,4,1,1,4,1,1,1 
	                      db 2,2,2,4,1,1,4,2,2,2 
	                      db 1,1,1,1,1,1,1,1,1,1 
	                      db 4,4,4,4,4,4,4,4,4,4 
	                      db 2,1,2,1,2,1,2,1,2,1 
	                      db 1,2,1,2,1,2,1,2,1,2                        
    brick_life_huanyuan3 db 2,2,2,2,2,2,2,2,2,2 ;第三关初始布局
	                      db 2,2,2,2,2,2,2,2,2,2 
	                      db 4,4,4,4,4,4,4,4,4,4 
	                      db 2,2,2,4,1,1,4,2,2,2 
	                      db 1,1,1,4,1,1,4,1,1,1 
	                      db 2,2,2,4,1,1,4,2,2,2 
	                      db 2,2,2,2,2,2,2,2,2,2 
	                      db 4,4,4,4,4,4,4,4,4,4 
	                      db 2,1,2,1,2,1,2,1,2,1 
	                      db 1,2,1,2,1,2,1,2,1,2                        
	brick_life_huanyuan4 db 4,4,4,4,4,4,4,4,4,4 ;第四关初始布局
	                      db 2,2,2,2,2,2,2,2,2,2 
	                      db 4,4,4,4,4,4,4,4,4,4 
	                      db 2,2,2,4,1,1,4,2,2,2 
	                      db 1,1,1,4,1,1,4,1,1,1 
	                      db 2,2,2,4,1,1,4,2,2,2 
	                      db 2,2,2,2,2,2,2,2,2,2 
	                      db 4,4,4,4,4,4,4,4,4,4 
	                      db 2,2,2,2,2,2,2,2,2,2 
	                      db 2,1,2,2,2,2,2,2,1,2                        
	brick_life_huanyuan5 db 4,4,4,4,4,4,4,4,4,4 ;第五关初始布局
	                      db 2,2,2,2,2,2,2,2,2,2 
	                      db 4,4,4,4,4,4,4,4,4,4 
	                      db 2,2,2,4,2,2,4,2,2,2 
	                      db 1,1,1,4,2,2,4,1,1,1 
	                      db 2,2,2,4,2,2,4,2,2,2 
	                      db 4,4,4,4,2,2,4,4,4,4 
	                      db 4,4,4,4,4,4,4,4,4,4 
	                      db 2,2,2,2,2,2,2,2,2,2 
	                      db 2,1,2,2,2,2,2,2,1,2 
    ;用来画道具和球，所有的道具都是10*10的 
    ball db 0,0,0,1,1,1,1,0,0,0;这个是球 
         db 0,1,1,1,1,1,1,1,1,0 
         db 0,1,1,1,1,1,1,1,1,0 
         db 1,1,1,1,1,1,1,1,1,1 
         db 1,1,1,1,1,1,1,1,1,1 
         db 1,1,1,1,1,1,1,1,1,1 
         db 1,1,1,1,1,1,1,1,1,1 
         db 0,1,1,1,1,1,1,1,1,0 
         db 0,1,1,1,1,1,1,1,1,0 
         db 0,0,0,1,1,1,1,0,0,0 
     
	add_life  db 0,0,1,0,0,0,0,1,0,0;增加生命的道具 
	          db 0,1,1,0,0,0,1,1,1,0 
	          db 1,1,1,1,0,0,1,1,1,1 
	          db 1,1,1,1,1,1,1,1,1,1 
	          db 1,1,1,1,1,1,1,1,1,1 
	          db 0,1,1,1,1,1,1,1,1,0 
	          db 0,1,1,1,1,1,1,1,1,0 
	          db 0,0,1,1,1,1,1,1,0,0 
	          db 0,0,0,1,1,1,1,0,0,0 
	          db 0,0,0,0,1,1,0,0,0,0 
         
	add_score db 0,0,0,0,1,1,0,0,0,0;增加分数的道具 
	          db 0,0,0,1,1,1,1,0,0,0 
	          db 0,0,1,1,1,1,1,1,0,0 
	          db 0,1,1,1,1,1,1,1,1,0 
	          db 1,1,1,1,1,1,1,1,1,1 
	          db 1,1,1,1,1,1,1,1,1,1 
	          db 0,1,1,1,1,1,1,1,1,0 
	          db 0,0,1,1,1,1,1,1,0,0 
	          db 0,0,0,1,1,1,1,0,0,0 
	          db 0,0,0,0,1,1,0,0,0,0 
           
	speed_up  db 0,0,1,0,0,0,0,1,0,0;加速的道具 
	          db 0,1,1,1,0,0,1,1,1,0 
	          db 1,1,1,1,1,1,1,1,1,1 
	          db 0,1,1,1,0,0,1,1,1,0 
	          db 0,0,1,0,0,0,0,1,0,0 
	          db 0,0,1,0,0,0,0,1,0,0 
	          db 0,1,1,1,0,0,1,1,1,0 
	          db 1,1,1,1,1,1,1,1,1,1 
	          db 0,1,1,1,0,0,1,1,1,0 
	          db 0,0,1,0,0,0,0,1,0,0 
           
	speed_down db 0,0,0,0,1,1,0,0,0,0;减速的道具 
	          db 0,0,1,1,1,1,1,1,0,0 
	          db 1,1,1,1,1,1,1,1,1,1 
	          db 0,0,1,1,1,1,1,1,0,0 
	          db 0,0,0,0,1,1,0,0,0,0 
	          db 0,0,0,0,1,1,0,0,0,0 
	          db 0,0,1,1,1,1,1,1,0,0 
	          db 1,1,1,1,1,1,1,1,1,1 
	          db 0,0,1,1,1,1,1,1,0,0 
	          db 0,0,0,0,1,1,0,0,0,0 
 
	lar_racket db 1,1,1,1,1,1,1,1,1,1;大球拍的道具 
	           db 1,1,1,1,1,1,1,1,1,1 
	           db 1,1,1,1,1,1,1,1,1,1 
	           db 0,0,0,0,0,0,0,0,0,0 
	           db 1,1,1,1,1,1,1,1,1,1 
	           db 1,1,1,1,1,1,1,1,1,1 
	           db 0,0,0,0,0,0,0,0,0,0 
	           db 1,1,1,1,1,1,1,1,1,1 
	           db 1,1,1,1,1,1,1,1,1,1 
	           db 1,1,1,1,1,1,1,1,1,1 
            
	sma_racket db 1,1,1,1,1,1,1,1,1,1;小球拍的道具 
	           db 1,1,1,1,1,1,1,1,1,1 
	           db 1,1,0,0,1,1,0,0,1,1 
	           db 1,0,1,1,0,0,1,1,0,1 
	           db 1,0,1,1,0,0,1,1,0,1 
	           db 1,0,1,1,0,0,1,1,0,1 
	           db 1,0,1,1,0,0,1,1,0,1 
	           db 1,0,1,1,0,0,1,1,0,1 
	           db 1,0,1,1,0,0,1,1,0,1 
	           db 1,1,1,1,1,1,1,1,1,1 
            
	bomb       db 0,0,0,0,0,0,0,1,1,1;普通炸弹的道具 
	           db 0,0,0,0,0,0,0,0,1,0 
	           db 0,0,1,1,1,1,0,0,1,0 
	           db 0,1,1,1,1,1,1,1,0,0 
	           db 0,1,1,1,1,1,1,1,0,0 
	           db 0,1,1,1,1,1,1,1,0,0 
	           db 0,1,1,1,1,1,1,1,0,0 
	           db 0,1,1,1,1,1,1,1,0,0 
	           db 0,0,1,1,1,1,1,0,0,0 
	           db 0,0,0,1,1,1,0,0,0,0 
 
	bigbomb       db 1,1,0,0,0,0,0,0,1,1;超级炸弹的道具 
	              db 1,1,1,0,0,0,0,1,1,1 
	              db 0,1,1,1,0,0,1,1,1,0 
	              db 0,0,1,1,1,1,1,1,0,0 
	              db 0,0,0,1,1,1,1,0,0,0 
	              db 0,0,0,1,1,1,1,1,0,0 
	              db 0,0,1,1,1,1,1,1,0,0 
	              db 0,1,1,1,0,0,1,1,1,0 
	              db 1,1,1,0,0,0,0,1,1,1 
	              db 1,1,0,0,0,0,0,0,1,1 
               
	showbomb      db 0,1,0,0,1,0,0,1,0,0;普通炸弹爆炸的样子 
	              db 0,0,1,0,1,0,1,0,0,1 
	              db 0,1,0,1,1,1,1,0,1,0 
	              db 1,0,1,1,0,0,1,1,0,0 
	              db 0,0,1,0,1,1,0,1,1,1 
	              db 1,1,1,0,1,1,0,1,0,0 
	              db 0,0,1,1,0,0,1,1,1,0 
	              db 0,1,0,1,1,1,1,0,0,1 
	              db 1,0,0,1,0,1,0,1,0,0 
	              db 0,0,1,0,0,1,0,0,1,0 
            
;xiaodou    db 0,0,0,0,1,1,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1;made by xiaodou 
           ;db 0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 
           ;db 0,0,0,0,1,1,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,0 
           ;db 0,0,1,0,1,1,0,1,0,0,0,0,0,0,1,1,0,0,0,0,1,1,0 
           ;db 0,1,1,0,1,1,0,1,1,0,0,0,0,0,1,1,0,0,0,0,1,1,0 
           ;db 1,1,0,0,1,1,0,0,1,1,0,0,0,0,1,1,1,1,1,1,1,1,0 
           ;db 1,0,0,0,1,1,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0 
           ;db 0,0,1,1,1,1,0,0,0,0,0,0,0,0,0,1,1,0,0,1,1,0,0 
           ;db 0,0,0,1,1,1,0,0,0,0,0,0,0,0,0,0,1,0,0,1,0,0,0 
           ;db 0,0,0,0,1,1,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1 
            ;
;zhizuo     db 0,1,0,1,0,0,0,0,0,1,0,0,0,0,0,1,0,0,0,1,0,0,0;zhizuo 
           ;db 0,1,0,1,0,0,0,1,0,1,0,0,0,0,1,1,0,0,1,1,0,0,0 
           ;db 0,1,1,1,1,1,0,1,0,1,0,0,0,1,1,0,0,1,1,1,1,1,1 
           ;db 1,0,0,1,0,0,0,1,0,1,0,0,0,1,1,0,1,1,1,0,0,0,0 
           ;db 0,1,1,1,1,1,0,1,0,1,0,0,0,0,1,0,0,0,1,1,1,1,1 
           ;db 0,0,0,1,0,0,0,1,0,1,0,0,0,0,1,0,0,0,1,0,0,0,0 
           ;db 0,1,1,1,1,1,0,1,0,1,0,0,0,0,1,0,0,0,1,0,0,0,0 
           ;db 0,1,0,1,0,1,0,1,0,1,0,0,0,0,1,0,0,0,1,1,1,1,1 
           ;db 0,1,0,1,0,1,0,0,0,1,0,0,0,0,1,0,0,0,1,0,0,0,0 
           ;db 0,0,0,1,0,0,0,0,1,1,0,0,0,0,1,0,0,0,1,0,0,0,0 
           
	MUS_FREG2 DW 330,392,330,294,330,392,330,294,330 ;音乐频率
	          DW 330,392,330,294,262,294,330,392,294 
	          DW 262,262,220,196,196,220,262,294,332,262,-1 
	MUS_TIME2 DW 3 DUP(50),25,25,50,25,25,100 ;音乐延时
	          DW 2 DUP(50,50,25,25),100 
	          DW 3 DUP(50,25,25),100 
	          
DATAS ENDS ;前280行为数据段





STACKS SEGMENT 
    ;此处输入堆栈段代码 
    hh dw 100 dup(?) 
STACKS ENDS 










;从第301行开始为代码段，380行之前为主函数
CODES SEGMENT 
    ASSUME CS:CODES,DS:DATAS,SS:STACKS 
START: 
    MOV AX,DATAS 
    MOV DS,AX 
    ;此处输入代码段代码  
    mov ax,0                            ;鼠标初始化选项
    int 33h 
    cmp ax,0                            ;在int 33h后检查ax的内容
    jz exit                             ;如果ax=0，没有鼠标，退出
	                                    ;将屏幕设置为320*200的显示分辨率，256色图形方式（VGA）
    mov ah,00 
    mov al,13h 
    int 10h 
;***********************************获取中断向量并保存 
    mov al,1ch                          ;al=中断号 es:bx=中断向量，1c是计时器控制
    mov ah,35h                          ;取中断向量
    int 21h 
    push es                             ;将附加段压入栈
    push bx 
    push ds                             ;将数据段压入栈
;***********************************置新的向量 
    mov dx,offset zhongduan             ;偏移地址，zhongduan是函数七
    mov ax,seg zhongduan                ;段地址
    mov ds,ax 
    mov al,1ch                          ;al=中断号 ds:dx=中断向量，1c是计时器控制
    mov ah,25h                          ;设置中断向量 
    int 21h 
    pop ds                              ;将数据段弹出栈
;***************************************************** 
    call inmenufun ;调用函数十八，开始进入画面
    call init ;调用函数十九，画出游戏初始界面
next2: 
    call mouse_racket ;调用函数十七，画出球拍的位置
    cmp exitflag,0;判断退出位是否有效，0为有效，若有效则退出 
    jz exit      
    cmp stopflag,1;如果stopflag有效，则进入暂停状态 
    jne nostop 
    call waitfun;调用函数六，暂停函数 
nostop: 
    ;判断replay的标志位是否为有效，如果有效（1），那么就重新开局 
    cmp replayflag,1 
    jne noreplay 
    call replayfun ;调用函数五，重玩
noreplay: 
    ;判断小球是不是已经都死光光了，如果是，那么调用函数，询问玩家是不是重新开局或者退出 
    cmp balldeadflag,1 
    jne noballdead 
    call balldeadfun ;调用函数四，显示小球死光后的界面
noballdead:  
	;判断是否有炸弹特效，当为0时说明没有特效   
    cmp bomb_flag,1 
    jne nobomb 
    call bomb_show ;调用函数一，炸弹特效
nobomb: 
    ;当所有的砖块都已经被击碎 
    cmp cmpgameflag,1 
    jne nocmpgame 
    call cmpgamefun ;调用函数三，顺利通关
nocmpgame:     
    jmp next2;循环，等待美妙18.2次的中断，对屏幕中的各个对象进行操作 
exit: 
    ;***********************************还原中断向量 
    pop dx ;bx
    pop ds ;es
    mov al,1ch ;al=中断号 ds:dx=中断向量
    mov ah,25h ;设置中断向量 
    int 21h 
     
    MOV AH,4CH ;设置
    INT 21H ;返回OS操作系统
    
    
    





;从第381行开始为二十一个函数实现
;****************************************************************** 
;当接到炸弹后，调用这个函数来实现特效 
bomb_show proc near ;函数一
    push ax 
    push bx 
    push cx 
 
    mov qidiany,45;先定位垂直方向 
    mov zhongdiany,75 
    mov al,inmenu_color 
    mov color,al 
    mov cx,13 
    mov propx,-2 
    mov propy,65 
    mov propflag,8 
show_loop1:;****************这个函数是把类似炸弹的东西画出来 
	    add bomb_color,50 
	    add propx,6 
	    sub propy,15 
	    call printprop  ;函数十二
	    call waitf  ;函数二
	    add bomb_color,33 
	    add propx,8 
	    add propy,15 
	    call printprop 
	    call waitf 
	    loop show_loop1 
	    mov propflag,-1;一定要把propflag置为-1，否则将会使prop下掉      
	    mov qidianx,4 
	    mov zhongdianx,8 
	    call setarea 
	    mov cx,194 
bomb_show_loop:;这个循环是用来从左到右把砖块划掉 
	    mov ax,qidianx 
	    mov zhongdianx,ax 
	    mov color,00 
	    call setarea    
	    add qidianx,1 
	    add zhongdianx,5 
	    mov al,inmenu_color 
	    mov color,al 
	    call setarea      
	    push cx 
	    mov ax,03fh 
bomb_show_delay:;延时 
       mov cx,0ffffh ;65535次
bomb_show_delay1: 
       add bx,1 
       loop bomb_show_delay1 
       sub ax,1 
       cmp ax,0 
       jne bomb_show_delay 
	   pop cx 
	   loop bomb_show_loop 
	   mov color,00 
	   call setarea 
bomb_show_exit: 
	    mov bomb_flag,0 
	    pop cx 
	    pop bx 
	    pop ax 
ret 
bomb_show endp 


;**************************************************************** 
;没什么好解释的吧，很简单的延时 
waitf proc near;函数二
   push cx 
       mov cx,0ffffh ;65535次
       waitf_1: 
           push cx 
           mov cx,01ffh ;511次
           waitf_2: 
           loop waitf_2 
           pop cx 
       loop waitf_1  
   pop cx 
ret 
waitf endp 


;****************************************************************** 
;当将所有的砖块都打完后，执行这个函数 
cmpgamefun proc near;函数三
;由一个光莲由上到下显示，将屏幕清空 
     add barflag,1 
     mov qidianx,0;设置在水平方向上，全部在操作范围内 
     mov zhongdianx,319 
     mov qidiany,0;设置垂直方向上，从0开始 
     mov zhongdiany,5 
     mov color,00 
     call setarea 
     mov cx,194 
     cmpgame_loop:;用循环操作，由上到下形成光莲 
          mov ax,qidiany;先将上面的一行擦去 
          mov zhongdiany,ax 
          mov color,00 
          call setarea 
          ;再在底下生成一行 
          add qidiany,1 
          add zhongdiany,5 
          mov color,1110b;光莲下卷时的颜色，最后给换成黄色之类的好看 
          call setarea 
     loop cmpgame_loop 
     mov zhongdiany,199 
     mov color,00 
     call setarea 
      
    ;将congratulation的信息写入 
    mov ah,02 
    mov bh,00 
    mov dh,8 
    mov dl,4 
    int 10h 	
    mov ah,09 
    lea dx,congratulation_msg 
    int 21h 
    ;将youscore的信息写入 
    mov ah,02 
    mov bh,00 
    mov dh,12 
    mov dl,4 
    int 10h 
    mov ah,09 
    lea dx,youscore_msg;'Your score is: 181$' 略有问题！！！
    ;call score_screen
    int 21h 
    ;将playagain的信息写入 
    mov ah,02 
    mov bh,00 
    mov dh,16 
    mov dl,4 
    int 10h 
    mov ah,09 
    lea dx,playagain_msg;'Play again?(Y/N)$' 
    int 21h 
     
    mov ah,01 ;输入单个字符并回显
    int 21h 
    cmp al,79h;y的ASCII码值 
    jne cmpgame_noy 
        mov qidianx,0;如果重玩，将刚显示的那个字给清除掉 
        mov zhongdianx,310 
        mov qidiany,30 
        mov zhongdiany,150 
        mov color,00 
        call setarea 
        call replayfun 
        jmp cmpgame_exit 
cmpgame_noy:      
    cmp al,59h;Y的ASCII的码值 
    jne cmpgame_nobigy 
        mov qidianx,0;如果重玩，将刚显示的那个字给清除掉 
        mov zhongdianx,310 
        mov qidiany,0 
        mov zhongdiany,199 
        mov color,00 
        call setarea          
        call replayfun 
        jmp cmpgame_exit 
cmpgame_nobigy: 
        mov exitflag,0;非y/Y字符都是不玩。如果不再玩，则退出的标志位置有效 
    cmpgame_exit:    
ret 
cmpgamefun endp 


;******************************************************************* 
;这个函数是当小球死光光了以后调用的 
balldeadfun proc near ;函数四
    mov ah,02;将光标置于中间 
    mov bh,00 
    mov dh,13 
    mov dl,8 
    int 10h 
    mov ah,09;将you lose的提示信息写入 
    lea dx,lose_msg 
    int 21h 
	;从键盘读取输入 
    mov ah,01 ;输入一个字符，al=输入的字符
    int 21h 
     
    cmp al,79h;y的ASCII码值，如果是y，那么重玩 
    jne balldead_noy 
          mov ah,02 
          mov bh,00 
          mov dh,13 
          mov dl,8 
          int 10h 
          ;将之前的字给清除掉 
          mov ah,09 
          lea dx,con1_msg 
          int 21h 
          call replayfun ;函数五
          jmp balldead_exit   
balldead_noy: 
        cmp al,59h;Y的ASCII的码值，如果是Y，那么重玩 
        jne balldead_nobigy 
        mov ah,02 
        mov bh,00 
        mov dh,13 
        mov dl,8 
        int 10h 
        ;将之前的字给清除掉 
        mov ah,09 
        lea dx,con1_msg 
        int 21h 
        call replayfun 
        jmp balldead_exit 
balldead_nobigy:      
        mov exitflag,0;非y/Y字符都是不玩。如果不重玩，则将推迟位的标志位置为有效 
balldead_exit:     
ret 
balldeadfun endp 


;******************************************************************* 
;replayfun这个函数是用来处理当用户按下r或者R时，进行内存数据重新赋值 
replayfun proc near ;函数五
    push ax 
    push bx 
    mov ax,ballx;先将以前的那个球给擦去 
    mov qidianx,ax 
    add ax,10 
    mov zhongdianx,ax 
    mov ax,bally 
    mov qidiany,ax 
    add ax,10 
    mov zhongdiany,ax 
    mov color,00 
    call setarea ;函数十四
    mov qidiany,193 ;将以前的那个球拍擦掉 
    mov zhongdiany,196 
    mov ax,mouse_last 
    mov qidianx,ax 
    add ax,racket_width 
    mov zhongdianx,ax 
    call setarea 
    ;判断是否在原屏幕上存在道具，如果存在，那么就将以前的那个道具擦去否则直接跳转 
    cmp propflag,-1 
    je replay_noprop 
         mov propflag,-1;以下的代码为将之前的那个道具擦去 
         mov ax,propx 
         mov qidianx,ax 
         add ax,10 
         mov zhongdianx,ax 
         mov ax,propy 
         mov qidiany,ax 
         add ax,10 
         mov zhongdiany,ax 
         mov color,00 
         call setarea 
replay_noprop: 
    ;调用init函数，因为在init函数中，变量都已经初始化，所以这里不用在将变量初始化 
    call init 
    pop bx 
    pop ax 
ret 
replayfun endp 


;******************************************************************* 
;waitfun这个函数是当用户按下空格时，游戏处于暂停状态 
waitfun proc near ;函数六
    push ax 
    cmp stopflag,1 
    jne waitfun_exit 
    ;将光标置于要显示信息的位置 
    mov ah,02 
    mov bh,00 
    mov dh,18 
    mov dl,1 
    int 10h 
    ;将stop_msg写入 
    mov ah,09 
    lea dx,stop_msg 
    int 21h 
     
waitfunloop:;等待再次按空格或者esc键 
       mov ah,07 ;键盘输入无回显
       int 21h 
       cmp al,20h 
       je waitfun_exit 
       cmp al,1bh;如果按的是esc键，那么将退出位置为有效 
       jne waitfunloop 
       mov exitflag,0 
waitfun_exit: 
    ;将光标置于要显示信息的位置 
    mov ah,02 
    mov bh,00 
    mov dh,18 
    mov dl,1 
    int 10h 
    mov ah,09;将stop_msg擦除，继续游戏 
    lea dx,con_msg 
    int 21h 
     
    mov stopflag,0;将暂停的控制位stopflag置为0，1为有效 
    pop ax 
ret 
waitfun endp 

;****************************************************************** 
;通过对系统中断向量的重置，可以使得程序以每秒18.2次的速度对小球和砖块进行处理。
zhongduan proc near ;函数七
    push ds 
    push ax 
    push cx 
    push dx 
    mov ax,DATAS 
    mov ds,ax 
    sti ;开中断
    cmp stopflag,1;如果是处于暂停时，那么定时中断什么都不做 
    je zhongduan_exit_1 
    cmp replayflag,1;如果是按下重玩后，则中断什么都不做 
    je zhongduan_exit_1 
    cmp inmenuflag,1;如果是最初始画面，则什么都不做 
    je zhongduan_exit_1 
    cmp balldeadflag,1;如果是小球死光光了，那么什么都不做 
    je zhongduan_exit_1  
    cmp cmpgameflag,1;如果是已经将所有的砖块都打完了 
    je zhongduan_exit_1      
    cmp bomb_flag,1;如果是炸弹效果，则什么都不做 
    je zhongduan_exit_1 
     
    call wave_brick_fun ;函数十一
    mov ah,6 ;直接控制台，AL=输入字符，DL=FF(输入)，DL=字符(输出)
    mov dl,0ffh 
    int 21h 
    cmp al,1bh;判断是不是有“Esc”按键 
    jne zhongduan_noesc;如果不是则跳转执行 
    mov exitflag,0;否则将退出为置为0，有效 
    jmp zhongduan_exit 
         
zhongduan_noesc: 
    cmp al,72h;判断是不是r，不是则跳转
    jne zhongduan_nor
    mov replayflag,1;如果是r，则将replay置为有效位1 
    jmp zhongduan_exit 
     
zhongduan_nor:;判断是不是R，不是则跳转 
    cmp al,52h 
    jne zhongduan_noR1 
    mov replayflag,1;如果是R，则将replay置为有效位1 
    jmp zhongduan_exit 
     
zhongduan_noR1: 
    cmp al,20h;判断是不是空格，如果是，则将stopflag置为1有效 
    jne zhongduan_nospace 
    mov stopflag,1 
    jmp zhongduan_exit_1 
    
zhongduan_nospace: 
     
zhongduan_exit:;结束本次中断的程序 
    call ballstep;函数八，将球的位置重新设置 
    call prop_screen  ;函数十六
    cmp speedflag,0 
    jz zhongduan_exit_1;判断是不是加速 
    call ballstep ;函数八
     
zhongduan_exit_1:     
    pop dx 
    pop cx 
    pop ax 
    pop ds 
iret ;返回调用者，中断
zhongduan endp 


;************************************************************************* 
;ballstep这个方法是用来处理小球运动函数 
ballstep proc near ;函数八
    push ax 
    push bx 
    push cx 
    push dx 
    mov color,00 
    call setball;函数十三，将之前的那个球给清除，重新画小球      
    call getpos;函数九，获得新的位置 
    cmp bally,185;如果小球落地，则生命值减一 
    jl notdeadball 
    sub life_num,1 
    cmp life_num,0;小球落地且生命值已经为0时执行下面的操作 
    jnl notdead 
         
    mov balldeadflag,1;将balldeadflag置为有效 
    jmp ballstep_exit 
 
notdead:;只是小球落地而还有生命值时，执行下面的操作 
        mov ah,02;先将光标移到生命值处，然后将提示信息和剩余生命值显示出来 
        mov bh,00 
        mov dh,6 
        mov dl,26 
        int 10h 
        mov ah,09 
        lea dx,life_msg;将life显示出来 
        int 21h 
        mov ah,02 ;显示一个字符
        mov dl,life_num 
        add dl,30h 
        int 21h;将剩余生命值显示出来 
        mov ballx,90;将小球的默认值初始化，用来记录球的左上角的x轴坐标 
        mov bally,183 
        mov x,2 
        mov y,-2 
        mov al,ball_color 
        mov  color,al 
        call setball;函数十三，将小球画出来 
         
        mov ax,mouse_last;将以前球拍擦去 
        mov qidianx,ax 
        mov zhongdianx,ax 
        mov ax,racket_width 
        add zhongdianx,ax 
        mov qidiany,193 
        mov zhongdiany,196 
        mov color,00 
        call setarea ;函数十四
        mov racket_width,30;将新的球拍显示出来 
        mov mouse_last,80 
        mov qidianx,80 
        mov zhongdianx,110 
        mov al,racket_color 
        mov color,al 
        call setarea ;函数十四
 
        mov cx,0ffffh;这段代码是用来延时的公延时511*65535次 
onlyfortime: 
        push cx 
        mov cx,0fffh ;511次
onlyfortime2: 
        mov ax,1 
        loop onlyfortime2 
        pop cx 
        loop onlyfortime 
        jmp ballstep_exit 
notdeadball: 
        mov al,ball_color 
        mov  color,al 
        call setball;函数十三，将球画出来 
        call hitbrick;调用函数十，对小球撞击之类的进行判断 
         
ballstep_exit: 
	    pop dx 
	    pop cx 
	    pop bx 
	    pop ax 
ret 
ballstep endp 


;************************************************************************* 
;getpos这个方法是通过对当前的 球的位置 以及 的运动向量 和球的速度 
;而得到新的 运动向量 和新的位置 
;这个方法是在当前的运动向量的前提下，得到小球的下一个位置。当与墙壁或者砖块相撞时，
;这个方法也要对运动向量进行一定的修改。
getpos proc near ;函数九
    push ax
    push bx 
    push cx 
    push dx 
    push si 
    push di 
    
    cmp x,0;先判断在x轴方向是向右还是向左 
    jnl posright 
    posleft:    ;如果是向左，那么它下一个位置在自己的左边 
	         mov cx,ballx ;用来记录球的左上角的x轴坐标 
	         add cx,x 
	         jmp posline1 
    posright:   ;否则下个位置在自己的右边 
	         mov cx,ballx 
	         add cx,x 
	         add cx,10 
    posline1:   ;先判断在水平方向的下一个位置处是不是有障碍 
		    mov dx,bally ;用来记录球的左上角的y轴坐标 
		    mov ah,0dh ;读图形像素，BH=页码，CX=x，DX=y
		    mov bh,00 
		    int 10h;获得下个位置处的像素值，存储在AL中 
		    cmp al,00 
		    ;je nonex;如是黑色，则x不发生变化 
		    je rightup 
		    neg x;否则x变反，NEG指令对标志的影响与用零作减法的SUB指令一样 
		    jmp rightup_exit         
    rightup: 
	        add cx,10 
	        int 10h ;获得下个位置处的像素值
		    cmp al,00 
		    je nonex 
	        neg x;否则x变反，NEG指令对标志的影响与用零作减法的SUB指令一样  
	        mov ax,x 
	        sub ballx,ax 
    nonex: 
	       mov ax,x 
	       add ballx,ax 
    rightup_exit:     
		    cmp y,0;再判断在垂直方向的运动方向，是向上还是向下
		    jl up 
    down:   ;如果是向下运动 
	         mov dx,bally 
	         add dx,9 
	         add dx,y 
	   		 jmp poschuizhi 
    up:  ;向上运动 
	         mov dx,bally 
	         add dx,y 
    poschuizhi:;判断在垂直方向的下一个位置是不是有障碍 
		    mov cx,ballx 
		    mov ah,0dh ;读图形像素，BH=页码，CX=x，DX=y
		    mov bh,00 
		    int 10h;获得垂直方向的下一个位置的像素颜色 
		    cmp al,00 
		    ;je noney;如果有则变反 
		    je rightcro 
		    neg y;如果y轴的方向变反，则在y轴方向的向量不变 
		    jmp rightcro_exit 
	rightcro: 
		    add cx,10 
		    int 10h ;获得下个位置处的像素值
		    cmp al,00 
		    je noney 
		    neg y 
		    jmp rightcro_exit   
    noney: 
	        mov ax,y 
	        add bally,ax 
    rightcro_exit:     
		    cmp y,0 
		    jl getpos_exit ;结束
		    mov ax,bally 
		    add ax,y 
		    cmp ax,185 
		    jl getpos_exit;判断是不是在球拍附近 
			;如果是，则要根据球拍的位置，而使球的方向向量做相应的变化 
		    mov ax,racket_width 
		    mov dx,mouse_last ;用于记录上一次的的鼠标的位置，只记录x轴 
		    cmp dx,ballx 
		    jnl getpos_exit;结束，如果是从球拍的右边出界 
		    add dx,ax 
		    cmp dx,ballx;判断是不是从左边出界 
		    jl getpos_exit  ;结束，如果出界    
		    mov dx,00;如果没有出界 
		    mov cx,3 
		    div cx 
		    ;ax存储的是球拍的三分之一长度 
		    mov cx,ballx 
		    ;add cx,5;取球的中央 
		    mov bx,mouse_last 
		    add bx,ax 
		    add bx,ax 
		    cmp bx,cx 
		    jnl getpos_notright;如果是在球拍左侧相撞 
		    cmp x,0 
		    jl right1 
		    mov x,4 
		    mov y,-2 
		    jmp getpos_exit ;结束
	right1: 
		    mov x,-2 
		    mov y,-4 
		    jmp getpos_exit ;结束
    getpos_notright: 
		    sub bx,ax 
		    cmp bx,cx 
		    jl getpos_exit;结束，如果是在球的中央相撞则不变 
		    cmp x,0 
	        jl left1 
	        mov x,2 
	        mov y,-4 
	        jmp getpos_exit ;结束
	 left1: 
	        mov x,-4 
	        mov y,-2 
     
    getpos_exit:         
	    pop di
	    pop si 
	    pop dx 
	    pop cx 
	    pop bx 
	    pop ax 
ret 
getpos endp 


;*********************************************************************** 
;这个方法是用来计算小球与砖块的碰撞的，是与哪一个砖块碰撞，它的抗击能力将减一 
;如果为0，则砖块消失,并加分 
hitbrick proc near ;函数十
    push ax;保存数据 
    push bx 
    push dx 
    push cx 
    push si 
         
    cmp bally,78;如果没到小于74，那么肯定不会与砖块相撞 
    jnl hitbrick_exitqq;那么就ret 
    mov si,0 
    mov ax,ballx ;用来记录球的左上角的x轴坐标 
    mov bx,bally ;用来记录球的左上角的y轴坐标 
    sub ax,x;ax中存储的是球的上个x位置 
    sub bx,y;bx中存储的是球的上个y位置 
    mov qidiany,3 
    mov cx,8 
    hit_lie: 
        cmp cx,bx 
        jnl hit_lie_exit;先判断行，每多一行，就多10个砖块 
        add cx,7 
        add qidiany,7 
        add si,10 
        jmp hit_lie 
    hit_lie_exit:      
	    mov cx,23 
	    mov qidianx,4 
    hit_line: 
        cmp cx,ax 
        jnl hit_line_exit;再判断列，每多一列，就多1个砖块在其中间 
        add cx,20 
        add qidianx,20 
        add si,1 
        jmp hit_line 
    hit_line_exit:     
	    cmp brick_life[si],0;判断是不是已经被击碎 
	    je hitbrick_exitqq;否则hit_next2      
    mov ah,0dh ;读图形像素，BH=页码，CX=x，DX=y
    mov bh,00 
    mov dx,qidiany 
    ;add dx,1 
    mov cx,qidianx 
    add cx,10 
    int 10h 
    
    cmp al,00 
    je hitbrick_exitqq      
    sub brick_life[si],1;将抗击能力减一 
    cmp brick_life[si],0;判断在这次撞击以后是不是击碎，如果是击碎，那么将它涂黑，否则跳出 
    jne hitbrick_exitqq      
    sub brick_num,1 
    cmp brick_num,0 
    jne gp 
    mov cmpgameflag,1;将完成位置为有效1 
 gp: 
    mov ax,qidianx;将那个砖块画为黑色的 
    add ax,18 
    mov zhongdianx,ax 
    mov ax,qidiany 
    add ax,5 
    mov zhongdiany,ax 
    mov color,00 
    call setarea; 函数十四
    mov al,brick_life_huanyuan1[si]
    add score_num,al 
    call score_screen ;函数十五
    ;下面的代码用来生成道具 
    cmp propflag,-1;如果已经有道具的存在，那么就不生成道具 
    jne hitbrick_exitqq  
    mov ax,ballx 
    mov propx,ax 
    mov ax,bally 
    add ax,13 
    mov propy,ax 
    ;当有砖块被击碎的时候，那么就有可能出现道具，具体是出现什么，要根据目前的砖块剩余数 
    cmp brick_num,99;如果剩余99个砖块，出现加速的道具 
    jne brick_num99 
    mov propflag,2 ;加速的道具
    jmp hitbrick_exitqq 
  brick_num99:      
    cmp brick_num,96 ;如果剩余96个砖块，出现普通炸弹
    jne brick_num96 
    mov propflag,6;普通炸弹的道具 
    jmp hitbrick_exitqq 
  brick_num96:      
    cmp brick_num,59 ;如果剩余59个砖块，出现大球拍
    jne brick_num93 
    mov propflag,4;大球拍的道具 
    jmp hitbrick_exitqq 
  brick_num93:      
    cmp brick_num,55 ;如果剩余55个砖块，出现加分数
    jne brick_num89 
    mov propflag,1;加分数的道具（加20分） 
    jmp hitbrick_exitqq 
  brick_num89:     
    cmp brick_num,52 ;如果剩余52个砖块，出现加生命
    jne brick_num57 
    mov propflag,0;加生命的道具 
    jmp hitbrick_exitqq 
  brick_num57:   
    cmp brick_num,49;如果剩余49个砖块，出现超级炸弹 
    jne brick_num54 
    mov propflag,2;超级炸弹的道具 
    jmp hitbrick_exitqq 
  brick_num54:        
    cmp brick_num,42 ;如果剩余42个砖块，出现减速
    jne brick_num48 
    mov propflag,3;减速的道具 
    jmp hitbrick_exitqq 
  brick_num48:   
    cmp brick_num,37 ;如果剩余37个砖块，出现小球拍
    jne brick_num42 
    mov propflag,5;小球拍的道具 
    jmp hitbrick_exitqq 
  brick_num42:     
    cmp brick_num,45 ;如果剩余45个砖块，出现加速
    jne brick_num40 
    mov propflag,7;加速的道具 
    jmp hitbrick_exitqq 
  brick_num40: 
     
hitbrick_exitqq: 
    pop si 
    pop cx 
    pop dx 
    pop bx 
    pop ax 
ret 
hitbrick endp 


;*********************************************************************** 
;这个函数是用来处理两个飘动挡板的 
wave_brick_fun proc near ;函数十一
    push ax  
    mov ax,qidiany 
    push ax 
    mov ax,zhongdiany 
    push ax 
    mov ax,qidianx 
    push ax 
    mov ax,zhongdianx 
    push ax 
     
    mov qidiany,100 
    mov zhongdiany,102 
    cmp wave_brick1_pos,1 ;1为向右移动，记录第一个档板的运动方向 
    je brick1_right     
brick1_left:   ;处理第一个挡板向左移动 
	        cmp wave_brick1,5 
	        jnb brick1_noleft 
	        mov wave_brick1_pos,1;如果是在最左边，则方向变反 
	        jmp brick1_exit 
brick1_noleft: 
            sub wave_brick1,1 
            mov ax,wave_brick1 
            mov qidianx,ax 
            add ax,20 
            mov zhongdianx,ax 
            mov color,70 
            call setarea              
            add ax,1 
            mov qidianx,ax 
            mov zhongdianx,ax 
            mov color,00 
            call setarea 
            jmp brick1_exit         
brick1_right:   ;处理第一个挡板向右移动 
       		cmp wave_brick1,182 
        	jne brick1_noright 
            mov wave_brick1_pos,0 ;如果是在最右边，则方向变反 
            jmp brick1_exit 
brick1_noright: 
            mov ax,wave_brick1 
            add wave_brick1,1 
            mov qidianx,ax 
            mov zhongdianx,ax 
            mov color,00 
            call setarea              
            mov qidianx,ax 
            add qidianx,1 
            mov zhongdianx,ax 
            add zhongdianx,21 
            mov color,70 
            call setarea             
brick1_exit: 
		    mov qidiany,130 
		    mov zhongdiany,132 
		    cmp wave_brick2_pos,1 ;0为向左移动，记录第二个档板的运动方向
		    je brick2_right 	    
brick2_left:   ;处理第二个挡板向左移动
        	cmp wave_brick2,5 
       		jnb brick2_noleft 
            mov wave_brick2_pos,1;如果是在最左边，则方向变反 
            jmp brick2_exit 
brick2_noleft:   
            sub wave_brick2,1 
            mov ax,wave_brick2 
            mov qidianx,ax 
            add ax,20 
            mov zhongdianx,ax 
            mov color,70 
            call setarea              
            add ax,1 
            mov qidianx,ax 
            mov zhongdianx,ax 
            mov color,00 
            call setarea 
        	jmp brick2_exit         	
brick2_right:   ;处理第二个挡板向右移动 
            cmp wave_brick2,182 
        	jne brick2_noright 
            mov wave_brick2_pos,0 ;如果是在最右边，则方向变反 
            jmp brick2_exit 
brick2_noright:   
            mov ax,wave_brick2 
            add wave_brick2,1 
            mov qidianx,ax 
            mov zhongdianx,ax 
            mov color,00 
            call setarea             
            mov qidianx,ax 
            add qidianx,1 
            mov zhongdianx,ax 
            add zhongdianx,21 
            mov color,70 
            call setarea 
brick2_exit: 
	    pop zhongdianx 
	    pop qidianx 
	    pop zhongdiany 
	    pop qidiany 
	    pop ax 
ret 
wave_brick_fun endp 


;*********************************************************************** 
;这个方法是用来画道具的，其中道具的左上角的x和y的位置已经存储在propx和propy中 
;另外，道具的颜色也有n种，根据不同的道具，选择不同的颜色 
printprop proc near ;函数十二
    push ax;保存数据 
    push bx 
    push cx 
    push dx 
    push si 
    push di 
     
    mov al,100;先用乘法，找到要画的道具的第一个元素的位置 
    mov bl,propflag 
    mul bl 
    mov si,ax;并将其送到si处 
    mov count,0 
     
    mov al,propflag;再将是第几个道具的db的性质的量扩展后送给di 
    mov ah,00h 
    mov di,ax 
 
    mov bh,00;显示页号为0 
    mov ah,0ch;写像素，AL=颜色，BH=页码 CX=x，DX=y  
    sub si,1;将从第一个开始读 
    mov dx,propy;得到球的左上角的坐标 
    sub dx,1 
    mov cx,propx 
    add cx,10;为了方便循环 
printprop_line:   ;画行 
    mov bl,0 
    add dx,1     
    sub cx,10 
printprop_lie:    ;画点 
      add bl,1;用于计数一行中的10个点 
      add cx,1 
      add si,1 
      mov al,prop_color[di];第n的颜色值 
      cmp add_life[si],00 
      jne printpropcolor;是否为黑点 
      mov al,00 
printpropcolor: 
      int 10h 
      
      add count,1 
      cmp bl,10 
      jb printprop_lie;当一行中的10个点画完后，进入外循环 
      cmp count,99 
      jb printprop_line;当100个点全部画完后，跳出 
    pop di 
    pop si 
    pop dx 
    pop cx 
    pop bx 
    pop ax  
ret 
printprop endp 


;************************************************************************ 
;setball这个方法是用来画出小球 
;左上角的位置和颜色都在内存中ballx和bally以及color中存储 
;小球的大小是固定不变的 
setball proc near ;函数十三
    push ax 
    push bx 
    push cx 
    push dx 
     
    mov bh,00;显示页号为0 
    mov ah,0ch;写像素，AL=颜色，BH=页码 CX=x，DX=y  
    mov si,-1;将从第一个开始读 
    mov dx,bally;得到球的左上角的坐标 
    sub dx,1 
    mov cx,ballx 
    add cx,10;为了方便循环 
setball_line:   ;画行 
    mov bl,0 
    add dx,1      
    sub cx,10 
setball_lie:    ;画点 
      add bl,1;用于计数一行中的10个点 
      add cx,1 
      add si,1 
      mov al,color 
      cmp ball[si],00 
      jne setballcolor;是否为黑点 
      mov al,00 
setballcolor: 
      int 10h 
      
    cmp bl,10 
    jb setball_lie;当一行中的10个点画完后，进入外循环  
    cmp si,99 
    jb setball_line;当100个点全部画完后，跳出      
setballexit: 
	    pop dx 
	    pop cx 
	    pop bx 
	    pop ax 
ret 
setball endp 

 
;************************************************************************ 
;这个方法是用来填充一个矩形的颜色。其中,矩形的左上角的坐标和右下角 
;坐标以及颜色值存储在内存变量中huaqidianx\huaqidiany\huazhongdianx 
;huazhongdiany\color  
setarea proc near; 函数十四
    push ax 
    push bx 
    push cx 
    push dx 
    push si 
     
    mov ah,0ch;写图形像素，AL=颜色，BH=页码 CX=x，DX=y 
    mov al,color 
    mov dx,qidiany ;DX=y
    sub dx,1 
next: 
    add dx,1 
    mov cx,qidianx ;CX=x
    sub cx,1 
next1: 
    add cx,1 
    int 10h 
    
    cmp cx,zhongdianx 
    jnz next1      
    cmp dx,zhongdiany 
    jnz next 
    mov color,al;将颜色再次返回给color。如果没有这一句，后面画的结果可能不确定。至于原因不清楚 
    
    pop si 
    pop dx 
    pop cx 
    pop bx 
    pop ax   
ret 
setarea endp    


;********************************************************** 
;这个方法是用来将分数写入屏幕的 
score_screen proc near ;函数十五
    push ax 
    push bx 
    push dx 
    push cx 
     
    mov ah,02 
    mov bh,00 
    mov dh,2 
    mov dl,33 
    int 10h 
    ;计算百位并写入 
    mov al,score_num 
    mov ah,0 
    mov cl,100 
    div cl 
    mov cl,ah 
    mov dl,al 
    add dl,30h 
    mov ah,02 
    int 21h 
    ;计算十位并写入 
    mov al,cl 
    mov ah,00 
    mov cl,10 
    div cl     
    mov cl,ah 
    mov ah,02 
    mov dl,al 
    add dl,30h 
    int 21h 
    ;写入个位 
    mov dl,cl 
    add dl,30h 
    int 21h 
     
    pop cx 
    pop dx 
    pop bx 
    pop ax 
ret 
score_screen endp 


;******************************************************************* 
;这个函数是对道具在屏幕中的运动进行处理的，即道具从上落下，直到落地或者被球拍接住
prop_screen proc near ;函数十六
    push ax 
    push bx 
    push cx 
    push dx 
    push si 
    cmp propflag,-1 
    je prop_screen_exit 
     
    mov bl,propflag 
    mov bh,00 
    mov al,prop_color[bx] 
    mov prop_color[bx],00 
    call printprop ;函数十二
    mov prop_color[bx],al;还原数据 
     
    cmp propy,187;如果落地 
    jl prop_screen_add 
    mov propflag,-1 
    ;将光标置于右边第三个框内,写入第二行 
    mov ah,02 
   	mov bh,00 
  	mov dh,11 
  	mov dl,28 
  	int 10h 
    ;将none_msg写入，由各个hint变为NULL 
   	mov ah,09 
   	lea dx,none_msg 
   	int 21h 
   	
    mov propflag,-1 
    jmp prop_screen_exit;结束 
    
prop_screen_add:      
    	cmp propy,183;如果被球拍碰上，则相应内存改变     
    	jl prop_screen_new 
        mov ax,mouse_last 
        cmp ax,propx 
        jnl prop_screen_new;如果在球拍的左侧掉下 
         
        add ax,racket_width 
        cmp ax,propx 
        jl prop_screen_new;如果在球拍的右侧掉下 
        cmp propflag,0;有道具，则要根据propflag的值判断是哪一个道具，然后做出相应的内存变化 
        jne notprop_addlife
        
        ;如果是接到增加生命的道具 
        add life_num,1;将光标置于右边第二个框内 
        mov ah,02 
        mov bh,00 
        mov dh,6 
        mov dl,26 
        int 10h 
        ;将life写入 
        mov ah,09 
        lea dx,life_msg 
        int 21h 
        ;将变化后的生命值写入 
        mov ah,02 
        mov dl,life_num 
        add dl,30h 
        int 21h 
        jmp addpropend 
notprop_addlife:              
        cmp propflag,1 
        jne notprop_addscore  
           			  
        ;如果是接到增加分数的道具  
        add score_num,20 
        call score_screen;函数十五   
        jmp addpropend 
notprop_addscore:             
        cmp propflag,2 
        jne notprop_speedup 
               
           ;如果是接到加速的道具 
               mov ax,x 
               mov bx,y 
               cmp ax,0;求出ax 的绝对值 
               jnl axbuxiaoyu0 
               neg ax ;求补指令，NEG指令对标志的影响与用零作减法的SUB指令一样
    axbuxiaoyu0: 
               cmp bx,0;求出bx的绝对值 
               jnl bxbuxiaoyu0 
               neg bx ;求补指令，NEG指令对标志的影响与用零作减法的SUB指令一样
    bxbuxiaoyu0:               
               add ax,bx;如果已经是中速或者快速，那么进行这个操作 
               cmp ax,5
			   jna MY_ADDR1
                   mov speedflag,1 
                   jmp addpropend 
            MY_ADDR1:                           
               mov ax,x;如果是慢速 
               mov bx,y 
               add ax,ax 
               add bx,bx 
               mov x,ax 
               mov y,bx 
               jmp addpropend  
notprop_speedup: 
               cmp propflag,3 
           	   jne notprop_speeddown 
           	   
           ;如果是接到减速的道具 
               cmp speedflag,1 
               jne speeddown_hh 
               mov speedflag,0 
               jmp addpropend 
   speeddown_hh:          
               mov score_num,3 
               call score_screen ;函数十五 
               cmp x,-3 
               jnl x1 
               mov x,-2 
               jmp shey 
            x1: 
                cmp x,0 
                jnl x2 
                mov x,-1 
                jmp shey 
             x2: 
                cmp x,4 
                jnl x3 
                mov x,1 
                jmp shey 
             x3: 
                mov x,2 
           shey:                
               cmp y,-3 
               jnl y1 
               mov y,-2 
               jmp addpropend 
            y1: 
                cmp y,0 
                jnl y2 
                mov y,-1 
                jmp addpropend 
             y2: 
                cmp y,4 
                jnl y3 
                mov y,1 
                jmp addpropend 
             y3: 
                mov y,2                
                jmp addpropend 
notprop_speeddown:           
		        cmp propflag,4 
		        jne notprop_bigracket 
		           
           ;如果是接到大球拍的道具 
	               cmp racket_width,29 
	               jl bigracket30 
	               mov racket_width,50 
	               jmp bigracket_screen 
   bigracket30: 
               	   mov racket_width,30 
bigracket_screen: 
                  mov qidiany,193 
                  mov zhongdiany,196 
                  mov al,racket_color 
                  mov color,al 
                  mov ax,mouse_last 
                  add ax,racket_width 
                  cmp ax,200 
                  jl racketkeyi 
                  mov zhongdianx,200 
                  mov ax,200 
                  sub ax,racket_width 
                  mov qidianx,ax 
                  call setarea 
                  jmp addpropend 
       racketkeyi: 
                  mov ax,mouse_last 
                  mov qidianx,ax 
                  add ax,racket_width 
                  mov zhongdianx,ax 
                  call setarea 
                  jmp addpropend 
notprop_bigracket:           
		           cmp propflag,5 
		           jne notprop_smallracket 
           
           ;如果是接到小球拍的道具 
               mov qidiany,193 
               mov zhongdiany,196 
               mov ax,mouse_last 
               mov qidianx,ax 
               add ax,racket_width 
               mov zhongdianx,ax 
               mov color,00 
               call setarea                     
               cmp racket_width,40 
               jnl smallracket30 
               
                   mov racket_width,20 
                   mov ax,qidianx 
                   add ax,20 
                   mov zhongdianx,ax 
                   mov al,racket_color 
                   mov color,al 
                   call setarea 
                   jmp addpropend 
     smallracket30: 
                   mov racket_width,30 
                   mov ax,qidianx 
                   add ax,30 
                   mov zhongdianx,ax 
                   mov al,racket_color 
                   mov color,al 
                   call setarea 
               jmp addpropend 
               
notprop_smallracket:            
           ;如果是接到普通炸弹的道具 
           cmp propflag,6 
           jne notbomb_1 
             ;mov qidiany,45 
             ;mov zhongdiany,75 
             ;mov qidianx,4 
             ;mov zhongdianx,202 
             ;mov color,00 
             ;call setarea 
             mov bomb_flag,1               
             add score_num,40 
             call score_screen ;函数十五
             mov brick_num,60;接到这个道具后，剩余的数量为60个砖块 
             mov si,59 
             mov cx,40 
             bomb_loop: 
                 add si,1 
                 mov brick_life[si],0 
                 loop bomb_loop 
             jmp addpropend 
            ;如果是接到超级炸弹的道具 
   notbomb_1: 
             mov cmpgameflag,1 
             mov score_num,181 
             call score_screen ;函数十五
             mov brick_num,0 
             mov si,-1 
             mov cx,99 
             bigbomb_loop: 
                 add si,1 
                 mov brick_life[si],0 
                 loop bigbomb_loop            
  addpropend: 
           ;将光标置于右边第三个框内,写入第二行， 
    		mov ah,02 
   			mov bh,00 
  			mov dh,11 
  		    mov dl,28 
  		    int 10h 
    		;将none_msg写入，由各个hint变为NULL 
   			mov ah,09 
   			lea dx,none_msg 
   			int 21h 
   			
            mov propflag,-1 
            jmp prop_screen_exit 
prop_screen_new: 
	    add propy,1 
	    call printprop ;函数十二
	    mov ah,02;将光标置于prop提示中的第二行 
	   	mov bh,00 
	  	mov dh,11 
	  	mov dl,28 
	  	int 10h 
	  	mov ah,09 
	  	cmp propflag,0 
	  	jne notlife 
  	    lea dx,addlife_msg;如果是增加生命的道具 
  	    int 21h 
  	    jmp prop_screen_exit 
  	notlife:   	 
		  	cmp propflag,1 
		  	jne notscore 
  	        lea dx,addscore_msg 
  	        int 21h 
  	        jmp prop_screen_exit 
  	notscore:   	 
		  	cmp propflag,2 
		  	jne notspeedup 
  	        lea dx,speed_up_msg 
  	        int 21h 
  	        jmp prop_screen_exit 
  	notspeedup:  
		  	cmp propflag,3 
		  	jne notspeeddown 
  	        lea dx,speed_down_msg 
  	        int 21h 
  	        jmp prop_screen_exit 
  	notspeeddown:   	 
		  	cmp propflag,4 
		  	jne notlargeracket 
  	        lea dx,large_racket_msg 
  	        int 21h 
  	        jmp prop_screen_exit 
  	notlargeracket:   	 
		  	cmp propflag,5 
		  	jne notsmallracket 
  	        lea dx,small_racket_msg 
  	        int 21h 
  	        jmp prop_screen_exit 
  	notsmallracket:   	 
		  	cmp propflag,6 
		  	jne notbomb 
	  	    lea dx,bomb_msg 
	  	    int 21h 
	  	    jmp prop_screen_exit 
  	notbomb:   	 
	  	   lea dx,bigbomb_msg 
	  	   int 21h 
	  	   jmp prop_screen_exit 
    prop_screen_exit: 
	    pop si 
	    pop dx 
	    pop cx 
	    pop bx 
	    pop ax  
ret 
prop_screen endp 


;******************************************************************** 
;是用来画出球拍的位置，其中球拍的左端位置以及球拍的宽度由内存记录 
mouse_racket proc near ;函数十七
    push ax 
    push bx 
    push cx 
    push dx 
    mov ax,0bh;读取鼠标变化位置量 
    int 33h 
    cmp cx,0 
    je mouse_racket_exit;如果没有移动则直接退出 
    jl mouse_racket_xiaoyu;如果是向右移动则跳转 
     
    mov dx,mouse_last;确定左角 
    mov qidianx,dx 
    add dx,cx 
     
    mov ax,dx;如果已经超出了199，则跳转 
    add ax,racket_width 
    cmp ax,203 
    jnl mouse_racket_exit 
     
    mov mouse_last,dx;先把左侧的画为黑色 
    mov zhongdianx,dx 
    mov qidiany,193 
    mov zhongdiany,196 
    mov color,00 
    call setarea 
     
    add dx,racket_width;再把右侧的画为球拍色 
    mov zhongdianx,dx 
    sub dx,cx 
    mov qidianx,dx 
    mov bl,racket_color 
    mov color,bl 
    call setarea 
     
    jmp mouse_racket_exit 
     
mouse_racket_xiaoyu:    ;如果是向右移动 
    mov dx,mouse_last 
    mov zhongdianx,dx 
    add dx,cx 
     
    cmp dx,4;如果超出了0则跳转 
    jl mouse_racket_exit 
     
    mov mouse_last,dx;右侧添为球拍色 
    mov qidianx,dx 
    mov qidiany,193 
    mov zhongdiany,196 
    mov bl,racket_color 
    mov color,bl 
    call setarea 
     
    add dx,racket_width;左侧为黑色 
    mov qidianx,dx 
    sub dx,cx 
    mov zhongdianx,dx 
    mov color,00 
    call setarea 
   
mouse_racket_exit: 
    pop dx 
    pop cx 
    pop bx 
    pop ax 
ret 
mouse_racket endp 


;************************************************************* 
;inmenufun这个函数是进入画面 
inmenufun proc near ;函数十八
    push ax 
    push bx 
    push cx 
    push dx 
     
    mov qidianx,0 
    mov qidiany,0 
    mov zhongdianx,320 
    mov zhongdiany,2 
    call setarea 
    mov al,inmenu_color 
    mov color,al 
    ;画左边 
    mov zhongdianx,3 
    mov zhongdiany,200 
    call setarea 
    ;画底部 
    mov qidianx,0 
    mov qidiany,197 
    mov zhongdianx,320 
    mov zhongdiany,200 
    call setarea 
    ;画右边 
    mov qidianx,317 
    mov qidiany,0 
    call setarea 
    mov dx,3;dx这里用来存放宽度 
    mov qidianx,0 
    mov zhongdianx,319 
    mov qidiany,0 
    mov al,inmenu_color 
    mov cx,50 
    inmenu_loop1:;这个是用来生成初始画面中的上边的线的 
        mov color,00 
        mov bx,qidiany 
        ;add bx,1 
        mov zhongdiany,bx 
        call setarea 
         
        add bx,1 
        mov qidiany,bx 
        add bx,dx 
        mov zhongdiany,bx 
        mov color,al 
        call setarea 
    loop inmenu_loop1 
    ;将光标置于上方 
    mov ah,02 
    mov bh,00 
    mov dh,4 
    mov dl,18 
    int 10h 
    ;将标题BRICK写入 
    mov ah,09 
    lea dx,brick_msg 
    int 21h 
     
    ;这段代码是所有的线条进入的代码 
    mov qidiany,54;线条的上下是固定的 
    mov zhongdiany,199 
    mov qidianx,0 
    mov al,inmenu_color 
 
    mov cx,70 
    mov bx,qidianx 
    push bx 
    inmenuloop2: 
        ;将左边的向右移动，先擦去一个像素列  
        ;mov bx,qidianx 
        pop bx ;将之前压栈的取出，使堆栈平衡 
        mov qidianx,bx 
        mov zhongdianx,bx 
        mov color,00 
        call setarea 
        ;再画一个像素列 
        add bx,1 
        push bx 
        mov qidianx,bx 
        add bx,5;宽度为5个像素 
        mov zhongdianx,bx 
        mov color,al 
        call setarea 
        ;画右边的 
        mov dx,319 
        sub dx,bx 
        mov qidianx,dx 
        mov zhongdianx,dx 
        call setarea 
        add qidianx,6 
        add zhongdianx,6 
        mov color,00 
        call setarea 
    loop inmenuloop2 
    pop bx;将之前压栈的取出，使堆栈平衡 
     
    ;将光标置于中间，写made by： 
    mov ah,02 
    mov bh,00 
    mov dh,11 
    mov dl,11 
    int 10h 
    ;将标题made by写入 
    mov ah,09 
    lea dx,mader_msg 
    int 21h 
     
    ;;画字——小豆 
    ;mov ah,0ch 
    ;mov bh,00 
    ;mov si,-1;将从第一个开始读 
    ;mov dx,110; 
    ;mov count,0 
    ;print_line:;画行 
    ;mov bl,0 
    ;add dx,1 
    ;mov cx,145 
    ;print_lie:;画点 
      ;add bl,1;用于计数一行中的10个点 
      ;add cx,1 
      ;add si,1 
      ;mov al,10 
      ;;cmp xiaodou[si],00 
      ;;jne printcolor;是否为黑点 
      ;mov al,00 
      ;printcolor: 
      ;int 10h 
      ;add count,1 
      ;cmp bl,23 
    ;jb print_lie;当一行中的10个点画完后，进入外循环  
    ;cmp count,229 
    ;jb print_line;当100个点全部画完后，跳出 
     
     
    ;;画字——制作 
    ;mov ah,0ch 
    ;mov bh,00 
    ;mov si,-1;将从第一个开始读 
    ;mov dx,125; 
    ;mov count,0 
    ;print_linezhizuo:;画行 
    ;mov bl,0 
    ;add dx,1 
    ;mov cx,145 
    ;print_liezhizuo:;画点 
      ;add bl,1;用于计数一行中的10个点 
      ;add cx,1 
      ;add si,1 
      ;mov al,10 
      ;; cmp zhizuo[si],00 
      ;;jne printcolorzhizuo;是否为黑点 
      ;mov al,00 
      ;printcolorzhizuo: 
      ;int 10h 
      ;add count,1 
      ;cmp bl,23 
    ;jb print_liezhizuo;当一行中的10个点画完后，进入外循环  
    ;cmp count,229 
    ;jb print_linezhizuo;当100个点全部画完后，跳出 
     
;    CALL MUSIC2 
     
    ;将光标置于中间，写press space to play~！ 
    mov ah,02 
    mov bh,00 
    mov dh,20 
    mov dl,10 
    int 10h 
    ;将标题play_msg写入 
    mov ah,09 
    lea dx,play_msg 
    int 21h 
     
    inmunuloop: 
        mov ah,07 ;键盘输入无回显
        int 21h 
        cmp al,20h 
        je inmunuloop_exit 
    jmp inmunuloop 
     
inmunuloop_exit: 
    mov qidianx,0 
    mov zhongdianx,319 
    mov qidiany,0 
    mov zhongdiany,199 
    mov color,00 
    call setarea 
    mov inmenuflag,0 
    pop dx 
    pop cx 
    pop bx 
    pop ax 
ret 
inmenufun endp 


;********************************************************************** 
;init这个方法是在程序开始运行时，画出界面用的 
;每次程序运行或者玩家重新开始时会调用一次 
init proc near ;函数十九
    push ax 
    push bx 
    push cx 
    push dx 
    push si ;源索引
    push di ;目的索引
     
    mov exitflag,1;用来记录玩家什么时候要退出游戏，当为0时退出 
    mov stopflag,0;用于记录什么时候暂停，如果是1则暂停 
    mov replayflag,0;用于记录是否重新开局，1为有效 
    mov propflag,-1;用来判断当前屏幕中是否有道具，如果没有则为-1，否则为相应的第0到n个道具 
    mov speedflag,0;用来判断是否要加速,如果为1则为加速 
    mov cmpgameflag,0;用来记录游戏中的所有砖块是否打完，如果打完，则为1 
    mov balldeadflag,0;用于记录当小球死光光后 
     
    mov count,0;这个变量是用来记录次数的 
    mov life_num,3;这个变量是用来记录生命值的 
    mov score_num,0;得分总和不能大于255 
    mov mouse_last,80;用于记录上一次的的鼠标的位置，只记录x轴 
    mov racket_width,30;用于记录球拍的宽度 
    mov ballx,90;用来记录球的左上角的x周坐标 
    mov bally,183;用来记录球的左上角的y周坐标 
    mov brick_num,100;用来记录砖块的数量 
    mov x,1;用于记录运动向量一号 
    mov y,-1;用于记录运动向量二号 
     
    mov al,frame_color;边框颜色
    mov color,al;设置颜色 
    ;画顶部 
    mov qidianx,0 
    mov qidiany,0 
    mov zhongdianx,320 
    mov zhongdiany,2 
    call setarea ;函数十四
    ;画左边 
    mov zhongdianx,3 
    mov zhongdiany,200 
    call setarea 
    ;画底部 
    mov qidianx,0 
    mov qidiany,197 
    mov zhongdianx,320 
    mov zhongdiany,200 
    call setarea 
    ;画右边 
    mov qidianx,317 
    mov qidiany,0 
    call setarea 
    ;画中间的分割线 
    mov qidianx,203 
    mov qidiany,2 
    mov zhongdianx,206 
    mov zhongdiany,200 
    call setarea 
    ;画右边的第一条分割线 
    mov qidianx,205 
    mov qidiany,30 
    mov zhongdianx,320 
    mov zhongdiany,32 
    call setarea 
    ;画右边的第二条分割线 
    mov qidiany,60 
    mov zhongdiany,62 
    call setarea 
    ;画右边的第三条分割线 
    mov qidiany,109 
    mov zhongdiany,111 
    call setarea 
    ;将光标置于右边第一个框内 
    mov ah,02 ;设置光标选项
    mov bh,00 ;0页
    mov dh,2 ;行的位置
    mov dl,26 ;列的位置
    int 10h 
    ;将score写如 
    mov ah,09 
    lea dx,score_msg 
    int 21h 
    call score_screen ;函数十五
    ;将光标置于右边第二个框内 
    mov ah,02 
    mov bh,00 
    mov dh,6 
    mov dl,26 
    int 10h 
    ;将life写入 
    mov ah,09 
    lea dx,life_msg 
    int 21h 
    ;将初始的生命值写入 
    mov ah,02 ;显示一个字符
    mov dl,life_num 
    add dl,30h 
    int 21h 
    ;将光标置于右边第三个框内 
    mov ah,02 
    mov bh,00 
    mov dh,09 
    mov dl,28 
    int 10h 
    ;将prop写入 
    mov ah,09 
    lea dx,prop_msg 
    int 21h 
    ;将光标置于右边第三个框内,写入第二行 
    mov ah,02 
    mov bh,00 
    mov dh,11 
    mov dl,28 
    int 10h 
    ;将none_msg写入 
    mov ah,09 
    lea dx,none_msg 
    int 21h 
     
    ;将光标置于右边第四个框内 
    mov ah,02 
    mov bh,00 
    mov dh,15 
    mov dl,27 
    int 10h 
    ;将hint1写入hint 
    mov ah,09 
    lea dx,hint_msg1 
    int 21h 
    ;光标下移，将esc的hint提示写入 
    mov ah,02 
    mov bh,00 
    mov dh,18 
    mov dl,26 
    int 10h 
    mov ah,09 
    lea dx,hint_msg2 
    int 21h 
    ;光标下移，将space的hint提示写入 
    mov ah,02 
    mov dh,20 
    mov dl,26 
    int 10h 
    mov ah,09 
    lea dx,hint_msg3 
    int 21h 
    ;光标下移，将人<r>的hint提示写入 
    mov ah,02 
    mov dh,22 
    mov dl,26 
    int 10h 
    mov ah,09 
    lea dx,hint_msg4 
    int 21h 
     
    ;将球拍画入 
    mov dl,racket_color 
    mov color,dl 
    mov qidianx,80 
    mov zhongdianx,110 
    mov qidiany,193 
    mov zhongdiany,196 
    call setarea 
    ;将初始的球画入 
     
    ;将砖块画入屏幕;先要将数据还原 
    mov cx,brick_num;得到砖块的数量 
    mov si,-1;为了方便循环 
    
	cmp barflag,1 ;用于记录是第几关，一共有5关
	jnz MY_ADDR2 
init_brick_huanyuan1:   ;这个循环是为了还原数据的，主要是用于在玩家重玩时 
    add si,1 
    mov al,brick_life_huanyuan1[si];将数据一一还原 
    mov brick_life[si],al 
    loop init_brick_huanyuan1 
    jmp huanyuan_end 
MY_ADDR2: 
    
    cmp barflag,2
    jnz MY_ADDR3	
init_brick_huanyuan2:   ;这个循环是为了还原数据的，主要是用于在玩家重玩时 
    add si,1 
    mov al,brick_life_huanyuan2[si];将数据一一还原 
    mov brick_life[si],al 
    loop init_brick_huanyuan2 
    jmp huanyuan_end 
MY_ADDR3: 
    
    cmp barflag,3
    jnz MY_ADDR4
init_brick_huanyuan3:   ;这个循环是为了还原数据的，主要是用于在玩家重玩时 
    add si,1 
    mov al,brick_life_huanyuan3[si];将数据一一还原 
    mov brick_life[si],al 
    loop init_brick_huanyuan3 
    jmp huanyuan_end 
MY_ADDR4:
    
    cmp barflag,4
    jnz MY_ADDR5
init_brick_huanyuan4:   ;这个循环是为了还原数据的，主要是用于在玩家重玩时 
    add si,1 
    mov al,brick_life_huanyuan4[si];将数据一一还原 
    mov brick_life[si],al 
    loop init_brick_huanyuan4 
    jmp huanyuan_end 
MY_ADDR5: 
    
    cmp barflag,5
    jnz MY_ADDR6
init_brick_huanyuan5:   ;这个循环是为了还原数据的，主要是用于在玩家重玩时 
    add si,1 
    mov al,brick_life_huanyuan5[si];将数据一一还原 
    mov brick_life[si],al 
    loop init_brick_huanyuan5 
    jmp huanyuan_end 
MY_ADDR6: 
         
huanyuan_end:      
    mov si,-1;这里是将还原后的砖块显示在屏幕上 
    mov di,0 
    mov qidianx,4;第一块砖块的左上角和右下角的坐标 
    mov zhongdianx,22 
    mov qidiany,3 
    mov zhongdiany,8 
     
init_brick:    ;用于将砖块画出 
    add si,1 
    add di,1 
    cmp si,brick_num;如果将所有的砖块已经画完则跳出 
    je init_brick_exit 
    
    mov al,brick_color1;如果是易碎砖块 
    cmp brick_life[si],1 
    je init_brick_color 
         
    mov al,brick_color2;如果是普通砖块 
    cmp brick_life[si],2 
    je init_brick_color 
         
    mov al,brick_color3;如果是硬质砖块 
init_brick_color: 
    mov color,al;将要画的砖块颜色送给color 
    call setarea;调用函数十四 
 
    cmp di,10;判断是否一行画完 
    jne brick_x 
    
        mov di,0;如果一行画完在y轴的值也变化，di也要置0 
        add zhongdiany,7 
        add qidiany,7 
        mov qidianx,-16;为了方便循环，这里将x的值赋予负值，在下面的add中增加 
        mov zhongdianx,2 
    brick_x:    ;将x的值增加，画下一个砖块 
        add qidianx,20 
        add zhongdianx,20 
    jmp init_brick 
init_brick_exit:    ;砖块画完 
    pop di 
    pop si 
    pop dx 
    pop cx 
    pop bx 
    pop ax 
ret 
init endp 


;********************************************************************** 
;以下的代码是用来发声
GENSOUND  PROC NEAR ;函数二十
          PUSH AX 
          PUSH BX 
          PUSH CX 
          PUSH DX 
          PUSH DI;目的索引
          MOV AL,0B6H;控制字
          OUT 43H,AL 
          MOV DX,12H 
          MOV AX,533H*2 ;AX为音符
          DIV DI 
          OUT 42H,AL ;低位字节
          MOV AL,AH 
          OUT 42H,AL  ;高位字节
          IN AL,61H ;获得端口B的当前设置
          MOV AH,AL ;保存
          OR AL,3 ;使PB0=1，PB1=1
          OUT 61H,AL ;打开扬声器
WAIT1:    MOV CX,8FF0H ;时延36848次
DELAY1:   LOOP DELAY1 ;DEC CX    JNZ DELAY1
          DEC BX 
          JNZ WAIT1 
          MOV AL,AH ;获得端口B的初始设置
          OUT 61H,AL ;关闭扬声器
          POP DI ;目的索引
          POP DX 
          POP CX 
          POP BX 
          POP AX 
          RET 
GENSOUND  ENDP 

MUSIC2    PROC NEAR ;函数二十一
          LEA SI,MUS_FREG2 ;取偏移地址
          LEA BP,DS:MUS_TIME2 ;取偏移地址
FREG2:    MOV DI,[SI] ;将DS:SI中的内容移到DI
          CMP DI,-1 
          JE END_MUS2 
          MOV DX,DS:[BP] ;将DS:BP中的内容移到DX
          MOV BX,1400 
          CALL GENSOUND 
          ADD SI,2 
          ADD BP,2 
FREG1:    MOV DI,[SI] ;将DS:SI中的内容移到DI
          CMP DI,-1 
          JE END_MUS2 
          MOV DX,DS:[BP] ;将DS:BP中的内容移到DX
          MOV BX,1400 
          CALL GENSOUND 
          ADD SI,2 
          ADD BP,2 
          JMP FREG1 
END_MUS2: 
          RET 
MUSIC2    ENDP 
;********************************************************************** 
CODES ENDS 
    END START

