DATAS segment ;ǰ280��Ϊ���ݶ�
    ;�˴��������ݶδ���  
    ;��Щ������������setarea���ݲ���������ʮ��
    qidianx dw 0 ;���x
    qidiany dw 0 ;���y
    zhongdianx dw 10 ;�յ�x
    zhongdiany dw 3 ;�յ�y
    color db 10 
    racket_color db 0111b;������ɫ����ɫ
    frame_color db 0110b;�߿���ɫ����ɫ 
    ball_color db 1110b;�����ɫ����ɫ
    brick_color1 db 1111b;����ש�����ɫ��������ɫ
    brick_color2 db 1010b;��ͨש�����ɫ��ǳ��ɫ
    brick_color3 db 0101b;Ӳ��ש�����ɫ��Ʒ��ɫ
    inmenu_color db 1110b; �ڲ��˵�����ɫ��x��ɫ
    wave_brick_color db 1001b;Ʈ���������ɫ��ǳ��ɫ 
    ;********************************************************* 
    exitflag dw 1;������¼���ʲôʱ��Ҫ�˳���Ϸ����Ϊ0ʱ�˳� 
    stopflag dw 0;���ڼ�¼ʲôʱ����ͣ�������1����ͣ 
    replayflag dw 0;���ڼ�¼�Ƿ����¿��֣�1Ϊ��Ч 
    propflag db -1;�����жϵ�ǰ��Ļ���Ƿ��е��ߣ����û����Ϊ-1������Ϊ��Ӧ�ĵ�0��n������ 
    speedflag dw 0;�����ж��Ƿ�Ҫ����,���Ϊ1��Ϊ���� 
    cmpgameflag db 0;������¼��Ϸ�е�����ש���Ƿ���꣬������꣬��Ϊ1 
    inmenuflag  db 1;�������ֻ�����ʼ���뻭��ʱ�õ���Ϊ�˷�ֹ�жϴ�ϣ����init�в���Ҫ������ʼ����1Ϊ��Ч 
    balldeadflag db 0;�ж�С�������ֵ�ǲ��Ƕ������ˣ����Ϊ1����ô����ζ��С��������� 
    barflag db 1;���ڼ�¼�ǵڼ��أ�һ����5�� 
    bomb_flag db 0;������ʾ���ӵ�bomb�����Ч����Ϊ0ʱ˵��û����Ч 
    ;********************************************************** 
    ;һЩҪ��ʾ���ַ� 
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
    ;��Щmsg�����ڵ��ߵ���ʾ�ϵ� 
    addlife_msg      db 'LIFE     $' ;������
    addscore_msg     db 'SCORE    $' ;������
    speed_up_msg     db 'SPEED UP $' ;�����
    speed_down_msg   db 'SPEEDDOWN$' ;�����
    large_racket_msg db 'L RACKET $' ;������
    small_racket_msg db 'S RACKET $' ;С����
    bomb_msg         db 'BOMB     $' ;��ͨը��
    bigbomb_msg      db 'SUP BOMB $' ;����ը��
     
    stop_msg db 'Press space to continue!$'; ����ͣ��ʱ��Ҫ������� 
    con_msg  db '                        $';�������ʱ�򣬽�֮ǰ���Ǹ������Ϳ�ɺ�ɫ 
    lose_msg db 'You lose!  Play again?(Y/N)$';������ֵΪ0ʱҪ�õ����msg 
    con1_msg db '                            $';�������ʱ�򣬽�֮ǰ���Ǹ������Ϳ�ɺ�ɫ 
     
    congratulation_msg db 'Congratulation!!You win!!$' 
    youscore_msg db 'Please enter next $';������ʾ Your score is: $
    playagain_msg db 'Play next level?(Y/N)$' 
    ;*********************************************************  
    ;Ҫ��¼����ֵ 
    wave_brick1 dw 15;��һ�����������ߵ�λ�� 
    wave_brick2 dw 170;�ڶ�����������ұߵ�λ�� 
    wave_brick1_pos db 1;1Ϊ�����ƶ�����¼��һ��������˶����� 
    wave_brick2_pos db 0;0Ϊ�����ƶ�����¼�ڶ���������˶����� 
    count db 0;���������������¼������ 
    bomb_count db 0;����ը������Ч 
    life_num db 3;��¼����ֵ 
    score_num db 0;�÷��ܺͲ��ܴ���255 
    mouse_last dw 80;���ڼ�¼��һ�εĵ�����λ�ã�ֻ��¼x�� 
    racket_width dw 30;���ڼ�¼���ĵĿ�� 
    ballx dw 90;������¼������Ͻǵ�x������ 
    bally dw 183;������¼������Ͻǵ�y������ 
    brick_num dw 100;������¼ש������� 
    x dw 1;���ڼ�¼�˶����� 
    y dw -1;���ڼ�¼�˶����� 
    propx dw 0;�������������������ʱ��������ߵ����Ͻǵ�x����Ϣ 
    propy dw 0;�������������������ʱ��������ߵ����Ͻǵ�y����Ϣ 
    ;����ǵ��ߵ���ɫ�����ǵ�˳����������ߵ�˳��һһ��Ӧ 
    prop_color db 0001b ;���������ĵ���
               db 0010b ;���ӷ����ĵ���
               db 0011b ;���ٵĵ���
               db 0100b ;���ٵĵ���
               db 1000b ;�����ĵĵ���
               db 1001b ;С���ĵĵ���
               db 1010b ;��ͨը���ĵ��� 
               db 1011b ;����ը���ĵ��� 
    bomb_color db 1100b ;
    ;*******������¼ש���ʣ������ֵ 
    brick_life db 100 dup(0) 
    brick_life_huanyuan1 db 2,2,2,2,4,2,2,2,2,2 ;��һ�س�ʼ����
			               db 1,1,4,1,1,4,1,1,1,1 
			               db 1,1,1,4,2,4,2,1,1,1 
			               db 2,1,2,4,1,1,1,2,1,2 
			               db 2,1,2,1,1,1,1,2,1,4 
			               db 1,1,1,2,1,1,4,1,1,4 
			               db 1,4,1,1,1,1,1,1,1,1 
			               db 1,1,1,2,1,2,1,2,1,2 
			               db 1,1,2,1,4,1,1,1,2,1 
			               db 2,1,1,1,1,1,1,1,1,2 
    brick_life_huanyuan2 db 2,2,2,2,2,2,2,2,2,2  ;�ڶ��س�ʼ����
	                      db 1,1,1,1,1,1,1,1,1,1 
	                      db 4,4,4,4,4,4,4,4,4,4 
	                      db 2,2,2,4,1,1,4,2,2,2 
	                      db 1,1,1,4,1,1,4,1,1,1 
	                      db 2,2,2,4,1,1,4,2,2,2 
	                      db 1,1,1,1,1,1,1,1,1,1 
	                      db 4,4,4,4,4,4,4,4,4,4 
	                      db 2,1,2,1,2,1,2,1,2,1 
	                      db 1,2,1,2,1,2,1,2,1,2                        
    brick_life_huanyuan3 db 2,2,2,2,2,2,2,2,2,2 ;�����س�ʼ����
	                      db 2,2,2,2,2,2,2,2,2,2 
	                      db 4,4,4,4,4,4,4,4,4,4 
	                      db 2,2,2,4,1,1,4,2,2,2 
	                      db 1,1,1,4,1,1,4,1,1,1 
	                      db 2,2,2,4,1,1,4,2,2,2 
	                      db 2,2,2,2,2,2,2,2,2,2 
	                      db 4,4,4,4,4,4,4,4,4,4 
	                      db 2,1,2,1,2,1,2,1,2,1 
	                      db 1,2,1,2,1,2,1,2,1,2                        
	brick_life_huanyuan4 db 4,4,4,4,4,4,4,4,4,4 ;���Ĺس�ʼ����
	                      db 2,2,2,2,2,2,2,2,2,2 
	                      db 4,4,4,4,4,4,4,4,4,4 
	                      db 2,2,2,4,1,1,4,2,2,2 
	                      db 1,1,1,4,1,1,4,1,1,1 
	                      db 2,2,2,4,1,1,4,2,2,2 
	                      db 2,2,2,2,2,2,2,2,2,2 
	                      db 4,4,4,4,4,4,4,4,4,4 
	                      db 2,2,2,2,2,2,2,2,2,2 
	                      db 2,1,2,2,2,2,2,2,1,2                        
	brick_life_huanyuan5 db 4,4,4,4,4,4,4,4,4,4 ;����س�ʼ����
	                      db 2,2,2,2,2,2,2,2,2,2 
	                      db 4,4,4,4,4,4,4,4,4,4 
	                      db 2,2,2,4,2,2,4,2,2,2 
	                      db 1,1,1,4,2,2,4,1,1,1 
	                      db 2,2,2,4,2,2,4,2,2,2 
	                      db 4,4,4,4,2,2,4,4,4,4 
	                      db 4,4,4,4,4,4,4,4,4,4 
	                      db 2,2,2,2,2,2,2,2,2,2 
	                      db 2,1,2,2,2,2,2,2,1,2 
    ;���������ߺ������еĵ��߶���10*10�� 
    ball db 0,0,0,1,1,1,1,0,0,0;������� 
         db 0,1,1,1,1,1,1,1,1,0 
         db 0,1,1,1,1,1,1,1,1,0 
         db 1,1,1,1,1,1,1,1,1,1 
         db 1,1,1,1,1,1,1,1,1,1 
         db 1,1,1,1,1,1,1,1,1,1 
         db 1,1,1,1,1,1,1,1,1,1 
         db 0,1,1,1,1,1,1,1,1,0 
         db 0,1,1,1,1,1,1,1,1,0 
         db 0,0,0,1,1,1,1,0,0,0 
     
	add_life  db 0,0,1,0,0,0,0,1,0,0;���������ĵ��� 
	          db 0,1,1,0,0,0,1,1,1,0 
	          db 1,1,1,1,0,0,1,1,1,1 
	          db 1,1,1,1,1,1,1,1,1,1 
	          db 1,1,1,1,1,1,1,1,1,1 
	          db 0,1,1,1,1,1,1,1,1,0 
	          db 0,1,1,1,1,1,1,1,1,0 
	          db 0,0,1,1,1,1,1,1,0,0 
	          db 0,0,0,1,1,1,1,0,0,0 
	          db 0,0,0,0,1,1,0,0,0,0 
         
	add_score db 0,0,0,0,1,1,0,0,0,0;���ӷ����ĵ��� 
	          db 0,0,0,1,1,1,1,0,0,0 
	          db 0,0,1,1,1,1,1,1,0,0 
	          db 0,1,1,1,1,1,1,1,1,0 
	          db 1,1,1,1,1,1,1,1,1,1 
	          db 1,1,1,1,1,1,1,1,1,1 
	          db 0,1,1,1,1,1,1,1,1,0 
	          db 0,0,1,1,1,1,1,1,0,0 
	          db 0,0,0,1,1,1,1,0,0,0 
	          db 0,0,0,0,1,1,0,0,0,0 
           
	speed_up  db 0,0,1,0,0,0,0,1,0,0;���ٵĵ��� 
	          db 0,1,1,1,0,0,1,1,1,0 
	          db 1,1,1,1,1,1,1,1,1,1 
	          db 0,1,1,1,0,0,1,1,1,0 
	          db 0,0,1,0,0,0,0,1,0,0 
	          db 0,0,1,0,0,0,0,1,0,0 
	          db 0,1,1,1,0,0,1,1,1,0 
	          db 1,1,1,1,1,1,1,1,1,1 
	          db 0,1,1,1,0,0,1,1,1,0 
	          db 0,0,1,0,0,0,0,1,0,0 
           
	speed_down db 0,0,0,0,1,1,0,0,0,0;���ٵĵ��� 
	          db 0,0,1,1,1,1,1,1,0,0 
	          db 1,1,1,1,1,1,1,1,1,1 
	          db 0,0,1,1,1,1,1,1,0,0 
	          db 0,0,0,0,1,1,0,0,0,0 
	          db 0,0,0,0,1,1,0,0,0,0 
	          db 0,0,1,1,1,1,1,1,0,0 
	          db 1,1,1,1,1,1,1,1,1,1 
	          db 0,0,1,1,1,1,1,1,0,0 
	          db 0,0,0,0,1,1,0,0,0,0 
 
	lar_racket db 1,1,1,1,1,1,1,1,1,1;�����ĵĵ��� 
	           db 1,1,1,1,1,1,1,1,1,1 
	           db 1,1,1,1,1,1,1,1,1,1 
	           db 0,0,0,0,0,0,0,0,0,0 
	           db 1,1,1,1,1,1,1,1,1,1 
	           db 1,1,1,1,1,1,1,1,1,1 
	           db 0,0,0,0,0,0,0,0,0,0 
	           db 1,1,1,1,1,1,1,1,1,1 
	           db 1,1,1,1,1,1,1,1,1,1 
	           db 1,1,1,1,1,1,1,1,1,1 
            
	sma_racket db 1,1,1,1,1,1,1,1,1,1;С���ĵĵ��� 
	           db 1,1,1,1,1,1,1,1,1,1 
	           db 1,1,0,0,1,1,0,0,1,1 
	           db 1,0,1,1,0,0,1,1,0,1 
	           db 1,0,1,1,0,0,1,1,0,1 
	           db 1,0,1,1,0,0,1,1,0,1 
	           db 1,0,1,1,0,0,1,1,0,1 
	           db 1,0,1,1,0,0,1,1,0,1 
	           db 1,0,1,1,0,0,1,1,0,1 
	           db 1,1,1,1,1,1,1,1,1,1 
            
	bomb       db 0,0,0,0,0,0,0,1,1,1;��ͨը���ĵ��� 
	           db 0,0,0,0,0,0,0,0,1,0 
	           db 0,0,1,1,1,1,0,0,1,0 
	           db 0,1,1,1,1,1,1,1,0,0 
	           db 0,1,1,1,1,1,1,1,0,0 
	           db 0,1,1,1,1,1,1,1,0,0 
	           db 0,1,1,1,1,1,1,1,0,0 
	           db 0,1,1,1,1,1,1,1,0,0 
	           db 0,0,1,1,1,1,1,0,0,0 
	           db 0,0,0,1,1,1,0,0,0,0 
 
	bigbomb       db 1,1,0,0,0,0,0,0,1,1;����ը���ĵ��� 
	              db 1,1,1,0,0,0,0,1,1,1 
	              db 0,1,1,1,0,0,1,1,1,0 
	              db 0,0,1,1,1,1,1,1,0,0 
	              db 0,0,0,1,1,1,1,0,0,0 
	              db 0,0,0,1,1,1,1,1,0,0 
	              db 0,0,1,1,1,1,1,1,0,0 
	              db 0,1,1,1,0,0,1,1,1,0 
	              db 1,1,1,0,0,0,0,1,1,1 
	              db 1,1,0,0,0,0,0,0,1,1 
               
	showbomb      db 0,1,0,0,1,0,0,1,0,0;��ͨը����ը������ 
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
           
	MUS_FREG2 DW 330,392,330,294,330,392,330,294,330 ;����Ƶ��
	          DW 330,392,330,294,262,294,330,392,294 
	          DW 262,262,220,196,196,220,262,294,332,262,-1 
	MUS_TIME2 DW 3 DUP(50),25,25,50,25,25,100 ;������ʱ
	          DW 2 DUP(50,50,25,25),100 
	          DW 3 DUP(50,25,25),100 
	          
DATAS ENDS ;ǰ280��Ϊ���ݶ�





STACKS SEGMENT 
    ;�˴������ջ�δ��� 
    hh dw 100 dup(?) 
STACKS ENDS 










;�ӵ�301�п�ʼΪ����Σ�380��֮ǰΪ������
CODES SEGMENT 
    ASSUME CS:CODES,DS:DATAS,SS:STACKS 
START: 
    MOV AX,DATAS 
    MOV DS,AX 
    ;�˴��������δ���  
    mov ax,0                            ;����ʼ��ѡ��
    int 33h 
    cmp ax,0                            ;��int 33h����ax������
    jz exit                             ;���ax=0��û����꣬�˳�
	                                    ;����Ļ����Ϊ320*200����ʾ�ֱ��ʣ�256ɫͼ�η�ʽ��VGA��
    mov ah,00 
    mov al,13h 
    int 10h 
;***********************************��ȡ�ж����������� 
    mov al,1ch                          ;al=�жϺ� es:bx=�ж�������1c�Ǽ�ʱ������
    mov ah,35h                          ;ȡ�ж�����
    int 21h 
    push es                             ;�����Ӷ�ѹ��ջ
    push bx 
    push ds                             ;�����ݶ�ѹ��ջ
;***********************************���µ����� 
    mov dx,offset zhongduan             ;ƫ�Ƶ�ַ��zhongduan�Ǻ�����
    mov ax,seg zhongduan                ;�ε�ַ
    mov ds,ax 
    mov al,1ch                          ;al=�жϺ� ds:dx=�ж�������1c�Ǽ�ʱ������
    mov ah,25h                          ;�����ж����� 
    int 21h 
    pop ds                              ;�����ݶε���ջ
;***************************************************** 
    call inmenufun ;���ú���ʮ�ˣ���ʼ���뻭��
    call init ;���ú���ʮ�ţ�������Ϸ��ʼ����
next2: 
    call mouse_racket ;���ú���ʮ�ߣ��������ĵ�λ��
    cmp exitflag,0;�ж��˳�λ�Ƿ���Ч��0Ϊ��Ч������Ч���˳� 
    jz exit      
    cmp stopflag,1;���stopflag��Ч���������ͣ״̬ 
    jne nostop 
    call waitfun;���ú���������ͣ���� 
nostop: 
    ;�ж�replay�ı�־λ�Ƿ�Ϊ��Ч�������Ч��1������ô�����¿��� 
    cmp replayflag,1 
    jne noreplay 
    call replayfun ;���ú����壬����
noreplay: 
    ;�ж�С���ǲ����Ѿ���������ˣ�����ǣ���ô���ú�����ѯ������ǲ������¿��ֻ����˳� 
    cmp balldeadflag,1 
    jne noballdead 
    call balldeadfun ;���ú����ģ���ʾС�������Ľ���
noballdead:  
	;�ж��Ƿ���ը����Ч����Ϊ0ʱ˵��û����Ч   
    cmp bomb_flag,1 
    jne nobomb 
    call bomb_show ;���ú���һ��ը����Ч
nobomb: 
    ;�����е�ש�鶼�Ѿ������� 
    cmp cmpgameflag,1 
    jne nocmpgame 
    call cmpgamefun ;���ú�������˳��ͨ��
nocmpgame:     
    jmp next2;ѭ�����ȴ�����18.2�ε��жϣ�����Ļ�еĸ���������в��� 
exit: 
    ;***********************************��ԭ�ж����� 
    pop dx ;bx
    pop ds ;es
    mov al,1ch ;al=�жϺ� ds:dx=�ж�����
    mov ah,25h ;�����ж����� 
    int 21h 
     
    MOV AH,4CH ;����
    INT 21H ;����OS����ϵͳ
    
    
    





;�ӵ�381�п�ʼΪ��ʮһ������ʵ��
;****************************************************************** 
;���ӵ�ը���󣬵������������ʵ����Ч 
bomb_show proc near ;����һ
    push ax 
    push bx 
    push cx 
 
    mov qidiany,45;�ȶ�λ��ֱ���� 
    mov zhongdiany,75 
    mov al,inmenu_color 
    mov color,al 
    mov cx,13 
    mov propx,-2 
    mov propy,65 
    mov propflag,8 
show_loop1:;****************��������ǰ�����ը���Ķ��������� 
	    add bomb_color,50 
	    add propx,6 
	    sub propy,15 
	    call printprop  ;����ʮ��
	    call waitf  ;������
	    add bomb_color,33 
	    add propx,8 
	    add propy,15 
	    call printprop 
	    call waitf 
	    loop show_loop1 
	    mov propflag,-1;һ��Ҫ��propflag��Ϊ-1�����򽫻�ʹprop�µ�      
	    mov qidianx,4 
	    mov zhongdianx,8 
	    call setarea 
	    mov cx,194 
bomb_show_loop:;���ѭ�������������Ұ�ש�黮�� 
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
bomb_show_delay:;��ʱ 
       mov cx,0ffffh ;65535��
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
;ûʲô�ý��͵İɣ��ܼ򵥵���ʱ 
waitf proc near;������
   push cx 
       mov cx,0ffffh ;65535��
       waitf_1: 
           push cx 
           mov cx,01ffh ;511��
           waitf_2: 
           loop waitf_2 
           pop cx 
       loop waitf_1  
   pop cx 
ret 
waitf endp 


;****************************************************************** 
;�������е�ש�鶼�����ִ��������� 
cmpgamefun proc near;������
;��һ���������ϵ�����ʾ������Ļ��� 
     add barflag,1 
     mov qidianx,0;������ˮƽ�����ϣ�ȫ���ڲ�����Χ�� 
     mov zhongdianx,319 
     mov qidiany,0;���ô�ֱ�����ϣ���0��ʼ 
     mov zhongdiany,5 
     mov color,00 
     call setarea 
     mov cx,194 
     cmpgame_loop:;��ѭ�����������ϵ����γɹ��� 
          mov ax,qidiany;�Ƚ������һ�в�ȥ 
          mov zhongdiany,ax 
          mov color,00 
          call setarea 
          ;���ڵ�������һ�� 
          add qidiany,1 
          add zhongdiany,5 
          mov color,1110b;�����¾�ʱ����ɫ���������ɻ�ɫ֮��ĺÿ� 
          call setarea 
     loop cmpgame_loop 
     mov zhongdiany,199 
     mov color,00 
     call setarea 
      
    ;��congratulation����Ϣд�� 
    mov ah,02 
    mov bh,00 
    mov dh,8 
    mov dl,4 
    int 10h 	
    mov ah,09 
    lea dx,congratulation_msg 
    int 21h 
    ;��youscore����Ϣд�� 
    mov ah,02 
    mov bh,00 
    mov dh,12 
    mov dl,4 
    int 10h 
    mov ah,09 
    lea dx,youscore_msg;'Your score is: 181$' �������⣡����
    ;call score_screen
    int 21h 
    ;��playagain����Ϣд�� 
    mov ah,02 
    mov bh,00 
    mov dh,16 
    mov dl,4 
    int 10h 
    mov ah,09 
    lea dx,playagain_msg;'Play again?(Y/N)$' 
    int 21h 
     
    mov ah,01 ;���뵥���ַ�������
    int 21h 
    cmp al,79h;y��ASCII��ֵ 
    jne cmpgame_noy 
        mov qidianx,0;������棬������ʾ���Ǹ��ָ������ 
        mov zhongdianx,310 
        mov qidiany,30 
        mov zhongdiany,150 
        mov color,00 
        call setarea 
        call replayfun 
        jmp cmpgame_exit 
cmpgame_noy:      
    cmp al,59h;Y��ASCII����ֵ 
    jne cmpgame_nobigy 
        mov qidianx,0;������棬������ʾ���Ǹ��ָ������ 
        mov zhongdianx,310 
        mov qidiany,0 
        mov zhongdiany,199 
        mov color,00 
        call setarea          
        call replayfun 
        jmp cmpgame_exit 
cmpgame_nobigy: 
        mov exitflag,0;��y/Y�ַ����ǲ��档��������棬���˳��ı�־λ����Ч 
    cmpgame_exit:    
ret 
cmpgamefun endp 


;******************************************************************* 
;��������ǵ�С����������Ժ���õ� 
balldeadfun proc near ;������
    mov ah,02;����������м� 
    mov bh,00 
    mov dh,13 
    mov dl,8 
    int 10h 
    mov ah,09;��you lose����ʾ��Ϣд�� 
    lea dx,lose_msg 
    int 21h 
	;�Ӽ��̶�ȡ���� 
    mov ah,01 ;����һ���ַ���al=������ַ�
    int 21h 
     
    cmp al,79h;y��ASCII��ֵ�������y����ô���� 
    jne balldead_noy 
          mov ah,02 
          mov bh,00 
          mov dh,13 
          mov dl,8 
          int 10h 
          ;��֮ǰ���ָ������ 
          mov ah,09 
          lea dx,con1_msg 
          int 21h 
          call replayfun ;������
          jmp balldead_exit   
balldead_noy: 
        cmp al,59h;Y��ASCII����ֵ�������Y����ô���� 
        jne balldead_nobigy 
        mov ah,02 
        mov bh,00 
        mov dh,13 
        mov dl,8 
        int 10h 
        ;��֮ǰ���ָ������ 
        mov ah,09 
        lea dx,con1_msg 
        int 21h 
        call replayfun 
        jmp balldead_exit 
balldead_nobigy:      
        mov exitflag,0;��y/Y�ַ����ǲ��档��������棬���Ƴ�λ�ı�־λ��Ϊ��Ч 
balldead_exit:     
ret 
balldeadfun endp 


;******************************************************************* 
;replayfun������������������û�����r����Rʱ�������ڴ��������¸�ֵ 
replayfun proc near ;������
    push ax 
    push bx 
    mov ax,ballx;�Ƚ���ǰ���Ǹ������ȥ 
    mov qidianx,ax 
    add ax,10 
    mov zhongdianx,ax 
    mov ax,bally 
    mov qidiany,ax 
    add ax,10 
    mov zhongdiany,ax 
    mov color,00 
    call setarea ;����ʮ��
    mov qidiany,193 ;����ǰ���Ǹ����Ĳ��� 
    mov zhongdiany,196 
    mov ax,mouse_last 
    mov qidianx,ax 
    add ax,racket_width 
    mov zhongdianx,ax 
    call setarea 
    ;�ж��Ƿ���ԭ��Ļ�ϴ��ڵ��ߣ�������ڣ���ô�ͽ���ǰ���Ǹ����߲�ȥ����ֱ����ת 
    cmp propflag,-1 
    je replay_noprop 
         mov propflag,-1;���µĴ���Ϊ��֮ǰ���Ǹ����߲�ȥ 
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
    ;����init��������Ϊ��init�����У��������Ѿ���ʼ�����������ﲻ���ڽ�������ʼ�� 
    call init 
    pop bx 
    pop ax 
ret 
replayfun endp 


;******************************************************************* 
;waitfun��������ǵ��û����¿ո�ʱ����Ϸ������ͣ״̬ 
waitfun proc near ;������
    push ax 
    cmp stopflag,1 
    jne waitfun_exit 
    ;���������Ҫ��ʾ��Ϣ��λ�� 
    mov ah,02 
    mov bh,00 
    mov dh,18 
    mov dl,1 
    int 10h 
    ;��stop_msgд�� 
    mov ah,09 
    lea dx,stop_msg 
    int 21h 
     
waitfunloop:;�ȴ��ٴΰ��ո����esc�� 
       mov ah,07 ;���������޻���
       int 21h 
       cmp al,20h 
       je waitfun_exit 
       cmp al,1bh;���������esc������ô���˳�λ��Ϊ��Ч 
       jne waitfunloop 
       mov exitflag,0 
waitfun_exit: 
    ;���������Ҫ��ʾ��Ϣ��λ�� 
    mov ah,02 
    mov bh,00 
    mov dh,18 
    mov dl,1 
    int 10h 
    mov ah,09;��stop_msg������������Ϸ 
    lea dx,con_msg 
    int 21h 
     
    mov stopflag,0;����ͣ�Ŀ���λstopflag��Ϊ0��1Ϊ��Ч 
    pop ax 
ret 
waitfun endp 

;****************************************************************** 
;ͨ����ϵͳ�ж����������ã�����ʹ�ó�����ÿ��18.2�ε��ٶȶ�С���ש����д���
zhongduan proc near ;������
    push ds 
    push ax 
    push cx 
    push dx 
    mov ax,DATAS 
    mov ds,ax 
    sti ;���ж�
    cmp stopflag,1;����Ǵ�����ͣʱ����ô��ʱ�ж�ʲô������ 
    je zhongduan_exit_1 
    cmp replayflag,1;����ǰ�����������ж�ʲô������ 
    je zhongduan_exit_1 
    cmp inmenuflag,1;��������ʼ���棬��ʲô������ 
    je zhongduan_exit_1 
    cmp balldeadflag,1;�����С��������ˣ���ôʲô������ 
    je zhongduan_exit_1  
    cmp cmpgameflag,1;������Ѿ������е�ש�鶼������ 
    je zhongduan_exit_1      
    cmp bomb_flag,1;�����ը��Ч������ʲô������ 
    je zhongduan_exit_1 
     
    call wave_brick_fun ;����ʮһ
    mov ah,6 ;ֱ�ӿ���̨��AL=�����ַ���DL=FF(����)��DL=�ַ�(���)
    mov dl,0ffh 
    int 21h 
    cmp al,1bh;�ж��ǲ����С�Esc������ 
    jne zhongduan_noesc;�����������תִ�� 
    mov exitflag,0;�����˳�Ϊ��Ϊ0����Ч 
    jmp zhongduan_exit 
         
zhongduan_noesc: 
    cmp al,72h;�ж��ǲ���r����������ת
    jne zhongduan_nor
    mov replayflag,1;�����r����replay��Ϊ��Чλ1 
    jmp zhongduan_exit 
     
zhongduan_nor:;�ж��ǲ���R����������ת 
    cmp al,52h 
    jne zhongduan_noR1 
    mov replayflag,1;�����R����replay��Ϊ��Чλ1 
    jmp zhongduan_exit 
     
zhongduan_noR1: 
    cmp al,20h;�ж��ǲ��ǿո�����ǣ���stopflag��Ϊ1��Ч 
    jne zhongduan_nospace 
    mov stopflag,1 
    jmp zhongduan_exit_1 
    
zhongduan_nospace: 
     
zhongduan_exit:;���������жϵĳ��� 
    call ballstep;�����ˣ������λ���������� 
    call prop_screen  ;����ʮ��
    cmp speedflag,0 
    jz zhongduan_exit_1;�ж��ǲ��Ǽ��� 
    call ballstep ;������
     
zhongduan_exit_1:     
    pop dx 
    pop cx 
    pop ax 
    pop ds 
iret ;���ص����ߣ��ж�
zhongduan endp 


;************************************************************************* 
;ballstep�����������������С���˶����� 
ballstep proc near ;������
    push ax 
    push bx 
    push cx 
    push dx 
    mov color,00 
    call setball;����ʮ������֮ǰ���Ǹ������������»�С��      
    call getpos;�����ţ�����µ�λ�� 
    cmp bally,185;���С����أ�������ֵ��һ 
    jl notdeadball 
    sub life_num,1 
    cmp life_num,0;С�����������ֵ�Ѿ�Ϊ0ʱִ������Ĳ��� 
    jnl notdead 
         
    mov balldeadflag,1;��balldeadflag��Ϊ��Ч 
    jmp ballstep_exit 
 
notdead:;ֻ��С����ض���������ֵʱ��ִ������Ĳ��� 
        mov ah,02;�Ƚ�����Ƶ�����ֵ����Ȼ����ʾ��Ϣ��ʣ������ֵ��ʾ���� 
        mov bh,00 
        mov dh,6 
        mov dl,26 
        int 10h 
        mov ah,09 
        lea dx,life_msg;��life��ʾ���� 
        int 21h 
        mov ah,02 ;��ʾһ���ַ�
        mov dl,life_num 
        add dl,30h 
        int 21h;��ʣ������ֵ��ʾ���� 
        mov ballx,90;��С���Ĭ��ֵ��ʼ����������¼������Ͻǵ�x������ 
        mov bally,183 
        mov x,2 
        mov y,-2 
        mov al,ball_color 
        mov  color,al 
        call setball;����ʮ������С�򻭳��� 
         
        mov ax,mouse_last;����ǰ���Ĳ�ȥ 
        mov qidianx,ax 
        mov zhongdianx,ax 
        mov ax,racket_width 
        add zhongdianx,ax 
        mov qidiany,193 
        mov zhongdiany,196 
        mov color,00 
        call setarea ;����ʮ��
        mov racket_width,30;���µ�������ʾ���� 
        mov mouse_last,80 
        mov qidianx,80 
        mov zhongdianx,110 
        mov al,racket_color 
        mov color,al 
        call setarea ;����ʮ��
 
        mov cx,0ffffh;��δ�����������ʱ�Ĺ���ʱ511*65535�� 
onlyfortime: 
        push cx 
        mov cx,0fffh ;511��
onlyfortime2: 
        mov ax,1 
        loop onlyfortime2 
        pop cx 
        loop onlyfortime 
        jmp ballstep_exit 
notdeadball: 
        mov al,ball_color 
        mov  color,al 
        call setball;����ʮ�������򻭳��� 
        call hitbrick;���ú���ʮ����С��ײ��֮��Ľ����ж� 
         
ballstep_exit: 
	    pop dx 
	    pop cx 
	    pop bx 
	    pop ax 
ret 
ballstep endp 


;************************************************************************* 
;getpos���������ͨ���Ե�ǰ�� ���λ�� �Լ� ���˶����� ������ٶ� 
;���õ��µ� �˶����� ���µ�λ�� 
;����������ڵ�ǰ���˶�������ǰ���£��õ�С�����һ��λ�á�����ǽ�ڻ���ש����ײʱ��
;�������ҲҪ���˶���������һ�����޸ġ�
getpos proc near ;������
    push ax
    push bx 
    push cx 
    push dx 
    push si 
    push di 
    
    cmp x,0;���ж���x�᷽�������һ������� 
    jnl posright 
    posleft:    ;�����������ô����һ��λ�����Լ������ 
	         mov cx,ballx ;������¼������Ͻǵ�x������ 
	         add cx,x 
	         jmp posline1 
    posright:   ;�����¸�λ�����Լ����ұ� 
	         mov cx,ballx 
	         add cx,x 
	         add cx,10 
    posline1:   ;���ж���ˮƽ�������һ��λ�ô��ǲ������ϰ� 
		    mov dx,bally ;������¼������Ͻǵ�y������ 
		    mov ah,0dh ;��ͼ�����أ�BH=ҳ�룬CX=x��DX=y
		    mov bh,00 
		    int 10h;����¸�λ�ô�������ֵ���洢��AL�� 
		    cmp al,00 
		    ;je nonex;���Ǻ�ɫ����x�������仯 
		    je rightup 
		    neg x;����x�䷴��NEGָ��Ա�־��Ӱ����������������SUBָ��һ�� 
		    jmp rightup_exit         
    rightup: 
	        add cx,10 
	        int 10h ;����¸�λ�ô�������ֵ
		    cmp al,00 
		    je nonex 
	        neg x;����x�䷴��NEGָ��Ա�־��Ӱ����������������SUBָ��һ��  
	        mov ax,x 
	        sub ballx,ax 
    nonex: 
	       mov ax,x 
	       add ballx,ax 
    rightup_exit:     
		    cmp y,0;���ж��ڴ�ֱ������˶����������ϻ�������
		    jl up 
    down:   ;����������˶� 
	         mov dx,bally 
	         add dx,9 
	         add dx,y 
	   		 jmp poschuizhi 
    up:  ;�����˶� 
	         mov dx,bally 
	         add dx,y 
    poschuizhi:;�ж��ڴ�ֱ�������һ��λ���ǲ������ϰ� 
		    mov cx,ballx 
		    mov ah,0dh ;��ͼ�����أ�BH=ҳ�룬CX=x��DX=y
		    mov bh,00 
		    int 10h;��ô�ֱ�������һ��λ�õ�������ɫ 
		    cmp al,00 
		    ;je noney;�������䷴ 
		    je rightcro 
		    neg y;���y��ķ���䷴������y�᷽����������� 
		    jmp rightcro_exit 
	rightcro: 
		    add cx,10 
		    int 10h ;����¸�λ�ô�������ֵ
		    cmp al,00 
		    je noney 
		    neg y 
		    jmp rightcro_exit   
    noney: 
	        mov ax,y 
	        add bally,ax 
    rightcro_exit:     
		    cmp y,0 
		    jl getpos_exit ;����
		    mov ax,bally 
		    add ax,y 
		    cmp ax,185 
		    jl getpos_exit;�ж��ǲ��������ĸ��� 
			;����ǣ���Ҫ�������ĵ�λ�ã���ʹ��ķ�����������Ӧ�ı仯 
		    mov ax,racket_width 
		    mov dx,mouse_last ;���ڼ�¼��һ�εĵ�����λ�ã�ֻ��¼x�� 
		    cmp dx,ballx 
		    jnl getpos_exit;����������Ǵ����ĵ��ұ߳��� 
		    add dx,ax 
		    cmp dx,ballx;�ж��ǲ��Ǵ���߳��� 
		    jl getpos_exit  ;�������������    
		    mov dx,00;���û�г��� 
		    mov cx,3 
		    div cx 
		    ;ax�洢�������ĵ�����֮һ���� 
		    mov cx,ballx 
		    ;add cx,5;ȡ������� 
		    mov bx,mouse_last 
		    add bx,ax 
		    add bx,ax 
		    cmp bx,cx 
		    jnl getpos_notright;����������������ײ 
		    cmp x,0 
		    jl right1 
		    mov x,4 
		    mov y,-2 
		    jmp getpos_exit ;����
	right1: 
		    mov x,-2 
		    mov y,-4 
		    jmp getpos_exit ;����
    getpos_notright: 
		    sub bx,ax 
		    cmp bx,cx 
		    jl getpos_exit;����������������������ײ�򲻱� 
		    cmp x,0 
	        jl left1 
	        mov x,2 
	        mov y,-4 
	        jmp getpos_exit ;����
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
;�����������������С����ש�����ײ�ģ�������һ��ש����ײ�����Ŀ�����������һ 
;���Ϊ0����ש����ʧ,���ӷ� 
hitbrick proc near ;����ʮ
    push ax;�������� 
    push bx 
    push dx 
    push cx 
    push si 
         
    cmp bally,78;���û��С��74����ô�϶�������ש����ײ 
    jnl hitbrick_exitqq;��ô��ret 
    mov si,0 
    mov ax,ballx ;������¼������Ͻǵ�x������ 
    mov bx,bally ;������¼������Ͻǵ�y������ 
    sub ax,x;ax�д洢��������ϸ�xλ�� 
    sub bx,y;bx�д洢��������ϸ�yλ�� 
    mov qidiany,3 
    mov cx,8 
    hit_lie: 
        cmp cx,bx 
        jnl hit_lie_exit;���ж��У�ÿ��һ�У��Ͷ�10��ש�� 
        add cx,7 
        add qidiany,7 
        add si,10 
        jmp hit_lie 
    hit_lie_exit:      
	    mov cx,23 
	    mov qidianx,4 
    hit_line: 
        cmp cx,ax 
        jnl hit_line_exit;���ж��У�ÿ��һ�У��Ͷ�1��ש�������м� 
        add cx,20 
        add qidianx,20 
        add si,1 
        jmp hit_line 
    hit_line_exit:     
	    cmp brick_life[si],0;�ж��ǲ����Ѿ������� 
	    je hitbrick_exitqq;����hit_next2      
    mov ah,0dh ;��ͼ�����أ�BH=ҳ�룬CX=x��DX=y
    mov bh,00 
    mov dx,qidiany 
    ;add dx,1 
    mov cx,qidianx 
    add cx,10 
    int 10h 
    
    cmp al,00 
    je hitbrick_exitqq      
    sub brick_life[si],1;������������һ 
    cmp brick_life[si],0;�ж������ײ���Ժ��ǲ��ǻ��飬����ǻ��飬��ô����Ϳ�ڣ��������� 
    jne hitbrick_exitqq      
    sub brick_num,1 
    cmp brick_num,0 
    jne gp 
    mov cmpgameflag,1;�����λ��Ϊ��Ч1 
 gp: 
    mov ax,qidianx;���Ǹ�ש�黭Ϊ��ɫ�� 
    add ax,18 
    mov zhongdianx,ax 
    mov ax,qidiany 
    add ax,5 
    mov zhongdiany,ax 
    mov color,00 
    call setarea; ����ʮ��
    mov al,brick_life_huanyuan1[si]
    add score_num,al 
    call score_screen ;����ʮ��
    ;����Ĵ����������ɵ��� 
    cmp propflag,-1;����Ѿ��е��ߵĴ��ڣ���ô�Ͳ����ɵ��� 
    jne hitbrick_exitqq  
    mov ax,ballx 
    mov propx,ax 
    mov ax,bally 
    add ax,13 
    mov propy,ax 
    ;����ש�鱻�����ʱ����ô���п��ܳ��ֵ��ߣ������ǳ���ʲô��Ҫ����Ŀǰ��ש��ʣ���� 
    cmp brick_num,99;���ʣ��99��ש�飬���ּ��ٵĵ��� 
    jne brick_num99 
    mov propflag,2 ;���ٵĵ���
    jmp hitbrick_exitqq 
  brick_num99:      
    cmp brick_num,96 ;���ʣ��96��ש�飬������ͨը��
    jne brick_num96 
    mov propflag,6;��ͨը���ĵ��� 
    jmp hitbrick_exitqq 
  brick_num96:      
    cmp brick_num,59 ;���ʣ��59��ש�飬���ִ�����
    jne brick_num93 
    mov propflag,4;�����ĵĵ��� 
    jmp hitbrick_exitqq 
  brick_num93:      
    cmp brick_num,55 ;���ʣ��55��ש�飬���ּӷ���
    jne brick_num89 
    mov propflag,1;�ӷ����ĵ��ߣ���20�֣� 
    jmp hitbrick_exitqq 
  brick_num89:     
    cmp brick_num,52 ;���ʣ��52��ש�飬���ּ�����
    jne brick_num57 
    mov propflag,0;�������ĵ��� 
    jmp hitbrick_exitqq 
  brick_num57:   
    cmp brick_num,49;���ʣ��49��ש�飬���ֳ���ը�� 
    jne brick_num54 
    mov propflag,2;����ը���ĵ��� 
    jmp hitbrick_exitqq 
  brick_num54:        
    cmp brick_num,42 ;���ʣ��42��ש�飬���ּ���
    jne brick_num48 
    mov propflag,3;���ٵĵ��� 
    jmp hitbrick_exitqq 
  brick_num48:   
    cmp brick_num,37 ;���ʣ��37��ש�飬����С����
    jne brick_num42 
    mov propflag,5;С���ĵĵ��� 
    jmp hitbrick_exitqq 
  brick_num42:     
    cmp brick_num,45 ;���ʣ��45��ש�飬���ּ���
    jne brick_num40 
    mov propflag,7;���ٵĵ��� 
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
;���������������������Ʈ������� 
wave_brick_fun proc near ;����ʮһ
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
    cmp wave_brick1_pos,1 ;1Ϊ�����ƶ�����¼��һ��������˶����� 
    je brick1_right     
brick1_left:   ;�����һ�����������ƶ� 
	        cmp wave_brick1,5 
	        jnb brick1_noleft 
	        mov wave_brick1_pos,1;�����������ߣ�����䷴ 
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
brick1_right:   ;�����һ�����������ƶ� 
       		cmp wave_brick1,182 
        	jne brick1_noright 
            mov wave_brick1_pos,0 ;����������ұߣ�����䷴ 
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
		    cmp wave_brick2_pos,1 ;0Ϊ�����ƶ�����¼�ڶ���������˶�����
		    je brick2_right 	    
brick2_left:   ;����ڶ������������ƶ�
        	cmp wave_brick2,5 
       		jnb brick2_noleft 
            mov wave_brick2_pos,1;�����������ߣ�����䷴ 
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
brick2_right:   ;����ڶ������������ƶ� 
            cmp wave_brick2,182 
        	jne brick2_noright 
            mov wave_brick2_pos,0 ;����������ұߣ�����䷴ 
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
;������������������ߵģ����е��ߵ����Ͻǵ�x��y��λ���Ѿ��洢��propx��propy�� 
;���⣬���ߵ���ɫҲ��n�֣����ݲ�ͬ�ĵ��ߣ�ѡ��ͬ����ɫ 
printprop proc near ;����ʮ��
    push ax;�������� 
    push bx 
    push cx 
    push dx 
    push si 
    push di 
     
    mov al,100;���ó˷����ҵ�Ҫ���ĵ��ߵĵ�һ��Ԫ�ص�λ�� 
    mov bl,propflag 
    mul bl 
    mov si,ax;�������͵�si�� 
    mov count,0 
     
    mov al,propflag;�ٽ��ǵڼ������ߵ�db�����ʵ�����չ���͸�di 
    mov ah,00h 
    mov di,ax 
 
    mov bh,00;��ʾҳ��Ϊ0 
    mov ah,0ch;д���أ�AL=��ɫ��BH=ҳ�� CX=x��DX=y  
    sub si,1;���ӵ�һ����ʼ�� 
    mov dx,propy;�õ�������Ͻǵ����� 
    sub dx,1 
    mov cx,propx 
    add cx,10;Ϊ�˷���ѭ�� 
printprop_line:   ;���� 
    mov bl,0 
    add dx,1     
    sub cx,10 
printprop_lie:    ;���� 
      add bl,1;���ڼ���һ���е�10���� 
      add cx,1 
      add si,1 
      mov al,prop_color[di];��n����ɫֵ 
      cmp add_life[si],00 
      jne printpropcolor;�Ƿ�Ϊ�ڵ� 
      mov al,00 
printpropcolor: 
      int 10h 
      
      add count,1 
      cmp bl,10 
      jb printprop_lie;��һ���е�10���㻭��󣬽�����ѭ�� 
      cmp count,99 
      jb printprop_line;��100����ȫ����������� 
    pop di 
    pop si 
    pop dx 
    pop cx 
    pop bx 
    pop ax  
ret 
printprop endp 


;************************************************************************ 
;setball�����������������С�� 
;���Ͻǵ�λ�ú���ɫ�����ڴ���ballx��bally�Լ�color�д洢 
;С��Ĵ�С�ǹ̶������ 
setball proc near ;����ʮ��
    push ax 
    push bx 
    push cx 
    push dx 
     
    mov bh,00;��ʾҳ��Ϊ0 
    mov ah,0ch;д���أ�AL=��ɫ��BH=ҳ�� CX=x��DX=y  
    mov si,-1;���ӵ�һ����ʼ�� 
    mov dx,bally;�õ�������Ͻǵ����� 
    sub dx,1 
    mov cx,ballx 
    add cx,10;Ϊ�˷���ѭ�� 
setball_line:   ;���� 
    mov bl,0 
    add dx,1      
    sub cx,10 
setball_lie:    ;���� 
      add bl,1;���ڼ���һ���е�10���� 
      add cx,1 
      add si,1 
      mov al,color 
      cmp ball[si],00 
      jne setballcolor;�Ƿ�Ϊ�ڵ� 
      mov al,00 
setballcolor: 
      int 10h 
      
    cmp bl,10 
    jb setball_lie;��һ���е�10���㻭��󣬽�����ѭ��  
    cmp si,99 
    jb setball_line;��100����ȫ�����������      
setballexit: 
	    pop dx 
	    pop cx 
	    pop bx 
	    pop ax 
ret 
setball endp 

 
;************************************************************************ 
;����������������һ�����ε���ɫ������,���ε����Ͻǵ���������½� 
;�����Լ���ɫֵ�洢���ڴ������huaqidianx\huaqidiany\huazhongdianx 
;huazhongdiany\color  
setarea proc near; ����ʮ��
    push ax 
    push bx 
    push cx 
    push dx 
    push si 
     
    mov ah,0ch;дͼ�����أ�AL=��ɫ��BH=ҳ�� CX=x��DX=y 
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
    mov color,al;����ɫ�ٴη��ظ�color�����û����һ�䣬���滭�Ľ�����ܲ�ȷ��������ԭ����� 
    
    pop si 
    pop dx 
    pop cx 
    pop bx 
    pop ax   
ret 
setarea endp    


;********************************************************** 
;�������������������д����Ļ�� 
score_screen proc near ;����ʮ��
    push ax 
    push bx 
    push dx 
    push cx 
     
    mov ah,02 
    mov bh,00 
    mov dh,2 
    mov dl,33 
    int 10h 
    ;�����λ��д�� 
    mov al,score_num 
    mov ah,0 
    mov cl,100 
    div cl 
    mov cl,ah 
    mov dl,al 
    add dl,30h 
    mov ah,02 
    int 21h 
    ;����ʮλ��д�� 
    mov al,cl 
    mov ah,00 
    mov cl,10 
    div cl     
    mov cl,ah 
    mov ah,02 
    mov dl,al 
    add dl,30h 
    int 21h 
    ;д���λ 
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
;��������ǶԵ�������Ļ�е��˶����д���ģ������ߴ������£�ֱ����ػ��߱����Ľ�ס
prop_screen proc near ;����ʮ��
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
    call printprop ;����ʮ��
    mov prop_color[bx],al;��ԭ���� 
     
    cmp propy,187;������ 
    jl prop_screen_add 
    mov propflag,-1 
    ;����������ұߵ���������,д��ڶ��� 
    mov ah,02 
   	mov bh,00 
  	mov dh,11 
  	mov dl,28 
  	int 10h 
    ;��none_msgд�룬�ɸ���hint��ΪNULL 
   	mov ah,09 
   	lea dx,none_msg 
   	int 21h 
   	
    mov propflag,-1 
    jmp prop_screen_exit;���� 
    
prop_screen_add:      
    	cmp propy,183;������������ϣ�����Ӧ�ڴ�ı�     
    	jl prop_screen_new 
        mov ax,mouse_last 
        cmp ax,propx 
        jnl prop_screen_new;��������ĵ������� 
         
        add ax,racket_width 
        cmp ax,propx 
        jl prop_screen_new;��������ĵ��Ҳ���� 
        cmp propflag,0;�е��ߣ���Ҫ����propflag��ֵ�ж�����һ�����ߣ�Ȼ��������Ӧ���ڴ�仯 
        jne notprop_addlife
        
        ;����ǽӵ����������ĵ��� 
        add life_num,1;����������ұߵڶ������� 
        mov ah,02 
        mov bh,00 
        mov dh,6 
        mov dl,26 
        int 10h 
        ;��lifeд�� 
        mov ah,09 
        lea dx,life_msg 
        int 21h 
        ;���仯�������ֵд�� 
        mov ah,02 
        mov dl,life_num 
        add dl,30h 
        int 21h 
        jmp addpropend 
notprop_addlife:              
        cmp propflag,1 
        jne notprop_addscore  
           			  
        ;����ǽӵ����ӷ����ĵ���  
        add score_num,20 
        call score_screen;����ʮ��   
        jmp addpropend 
notprop_addscore:             
        cmp propflag,2 
        jne notprop_speedup 
               
           ;����ǽӵ����ٵĵ��� 
               mov ax,x 
               mov bx,y 
               cmp ax,0;���ax �ľ���ֵ 
               jnl axbuxiaoyu0 
               neg ax ;��ָ�NEGָ��Ա�־��Ӱ����������������SUBָ��һ��
    axbuxiaoyu0: 
               cmp bx,0;���bx�ľ���ֵ 
               jnl bxbuxiaoyu0 
               neg bx ;��ָ�NEGָ��Ա�־��Ӱ����������������SUBָ��һ��
    bxbuxiaoyu0:               
               add ax,bx;����Ѿ������ٻ��߿��٣���ô����������� 
               cmp ax,5
			   jna MY_ADDR1
                   mov speedflag,1 
                   jmp addpropend 
            MY_ADDR1:                           
               mov ax,x;��������� 
               mov bx,y 
               add ax,ax 
               add bx,bx 
               mov x,ax 
               mov y,bx 
               jmp addpropend  
notprop_speedup: 
               cmp propflag,3 
           	   jne notprop_speeddown 
           	   
           ;����ǽӵ����ٵĵ��� 
               cmp speedflag,1 
               jne speeddown_hh 
               mov speedflag,0 
               jmp addpropend 
   speeddown_hh:          
               mov score_num,3 
               call score_screen ;����ʮ�� 
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
		           
           ;����ǽӵ������ĵĵ��� 
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
           
           ;����ǽӵ�С���ĵĵ��� 
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
           ;����ǽӵ���ͨը���ĵ��� 
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
             call score_screen ;����ʮ��
             mov brick_num,60;�ӵ�������ߺ�ʣ�������Ϊ60��ש�� 
             mov si,59 
             mov cx,40 
             bomb_loop: 
                 add si,1 
                 mov brick_life[si],0 
                 loop bomb_loop 
             jmp addpropend 
            ;����ǽӵ�����ը���ĵ��� 
   notbomb_1: 
             mov cmpgameflag,1 
             mov score_num,181 
             call score_screen ;����ʮ��
             mov brick_num,0 
             mov si,-1 
             mov cx,99 
             bigbomb_loop: 
                 add si,1 
                 mov brick_life[si],0 
                 loop bigbomb_loop            
  addpropend: 
           ;����������ұߵ���������,д��ڶ��У� 
    		mov ah,02 
   			mov bh,00 
  			mov dh,11 
  		    mov dl,28 
  		    int 10h 
    		;��none_msgд�룬�ɸ���hint��ΪNULL 
   			mov ah,09 
   			lea dx,none_msg 
   			int 21h 
   			
            mov propflag,-1 
            jmp prop_screen_exit 
prop_screen_new: 
	    add propy,1 
	    call printprop ;����ʮ��
	    mov ah,02;���������prop��ʾ�еĵڶ��� 
	   	mov bh,00 
	  	mov dh,11 
	  	mov dl,28 
	  	int 10h 
	  	mov ah,09 
	  	cmp propflag,0 
	  	jne notlife 
  	    lea dx,addlife_msg;��������������ĵ��� 
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
;�������������ĵ�λ�ã��������ĵ����λ���Լ����ĵĿ�����ڴ��¼ 
mouse_racket proc near ;����ʮ��
    push ax 
    push bx 
    push cx 
    push dx 
    mov ax,0bh;��ȡ���仯λ���� 
    int 33h 
    cmp cx,0 
    je mouse_racket_exit;���û���ƶ���ֱ���˳� 
    jl mouse_racket_xiaoyu;����������ƶ�����ת 
     
    mov dx,mouse_last;ȷ����� 
    mov qidianx,dx 
    add dx,cx 
     
    mov ax,dx;����Ѿ�������199������ת 
    add ax,racket_width 
    cmp ax,203 
    jnl mouse_racket_exit 
     
    mov mouse_last,dx;�Ȱ����Ļ�Ϊ��ɫ 
    mov zhongdianx,dx 
    mov qidiany,193 
    mov zhongdiany,196 
    mov color,00 
    call setarea 
     
    add dx,racket_width;�ٰ��Ҳ�Ļ�Ϊ����ɫ 
    mov zhongdianx,dx 
    sub dx,cx 
    mov qidianx,dx 
    mov bl,racket_color 
    mov color,bl 
    call setarea 
     
    jmp mouse_racket_exit 
     
mouse_racket_xiaoyu:    ;����������ƶ� 
    mov dx,mouse_last 
    mov zhongdianx,dx 
    add dx,cx 
     
    cmp dx,4;���������0����ת 
    jl mouse_racket_exit 
     
    mov mouse_last,dx;�Ҳ���Ϊ����ɫ 
    mov qidianx,dx 
    mov qidiany,193 
    mov zhongdiany,196 
    mov bl,racket_color 
    mov color,bl 
    call setarea 
     
    add dx,racket_width;���Ϊ��ɫ 
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
;inmenufun��������ǽ��뻭�� 
inmenufun proc near ;����ʮ��
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
    ;����� 
    mov zhongdianx,3 
    mov zhongdiany,200 
    call setarea 
    ;���ײ� 
    mov qidianx,0 
    mov qidiany,197 
    mov zhongdianx,320 
    mov zhongdiany,200 
    call setarea 
    ;���ұ� 
    mov qidianx,317 
    mov qidiany,0 
    call setarea 
    mov dx,3;dx����������ſ�� 
    mov qidianx,0 
    mov zhongdianx,319 
    mov qidiany,0 
    mov al,inmenu_color 
    mov cx,50 
    inmenu_loop1:;������������ɳ�ʼ�����е��ϱߵ��ߵ� 
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
    ;����������Ϸ� 
    mov ah,02 
    mov bh,00 
    mov dh,4 
    mov dl,18 
    int 10h 
    ;������BRICKд�� 
    mov ah,09 
    lea dx,brick_msg 
    int 21h 
     
    ;��δ��������е���������Ĵ��� 
    mov qidiany,54;�����������ǹ̶��� 
    mov zhongdiany,199 
    mov qidianx,0 
    mov al,inmenu_color 
 
    mov cx,70 
    mov bx,qidianx 
    push bx 
    inmenuloop2: 
        ;����ߵ������ƶ����Ȳ�ȥһ��������  
        ;mov bx,qidianx 
        pop bx ;��֮ǰѹջ��ȡ����ʹ��ջƽ�� 
        mov qidianx,bx 
        mov zhongdianx,bx 
        mov color,00 
        call setarea 
        ;�ٻ�һ�������� 
        add bx,1 
        push bx 
        mov qidianx,bx 
        add bx,5;���Ϊ5������ 
        mov zhongdianx,bx 
        mov color,al 
        call setarea 
        ;���ұߵ� 
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
    pop bx;��֮ǰѹջ��ȡ����ʹ��ջƽ�� 
     
    ;����������м䣬дmade by�� 
    mov ah,02 
    mov bh,00 
    mov dh,11 
    mov dl,11 
    int 10h 
    ;������made byд�� 
    mov ah,09 
    lea dx,mader_msg 
    int 21h 
     
    ;;���֡���С�� 
    ;mov ah,0ch 
    ;mov bh,00 
    ;mov si,-1;���ӵ�һ����ʼ�� 
    ;mov dx,110; 
    ;mov count,0 
    ;print_line:;���� 
    ;mov bl,0 
    ;add dx,1 
    ;mov cx,145 
    ;print_lie:;���� 
      ;add bl,1;���ڼ���һ���е�10���� 
      ;add cx,1 
      ;add si,1 
      ;mov al,10 
      ;;cmp xiaodou[si],00 
      ;;jne printcolor;�Ƿ�Ϊ�ڵ� 
      ;mov al,00 
      ;printcolor: 
      ;int 10h 
      ;add count,1 
      ;cmp bl,23 
    ;jb print_lie;��һ���е�10���㻭��󣬽�����ѭ��  
    ;cmp count,229 
    ;jb print_line;��100����ȫ����������� 
     
     
    ;;���֡������� 
    ;mov ah,0ch 
    ;mov bh,00 
    ;mov si,-1;���ӵ�һ����ʼ�� 
    ;mov dx,125; 
    ;mov count,0 
    ;print_linezhizuo:;���� 
    ;mov bl,0 
    ;add dx,1 
    ;mov cx,145 
    ;print_liezhizuo:;���� 
      ;add bl,1;���ڼ���һ���е�10���� 
      ;add cx,1 
      ;add si,1 
      ;mov al,10 
      ;; cmp zhizuo[si],00 
      ;;jne printcolorzhizuo;�Ƿ�Ϊ�ڵ� 
      ;mov al,00 
      ;printcolorzhizuo: 
      ;int 10h 
      ;add count,1 
      ;cmp bl,23 
    ;jb print_liezhizuo;��һ���е�10���㻭��󣬽�����ѭ��  
    ;cmp count,229 
    ;jb print_linezhizuo;��100����ȫ����������� 
     
;    CALL MUSIC2 
     
    ;����������м䣬дpress space to play~�� 
    mov ah,02 
    mov bh,00 
    mov dh,20 
    mov dl,10 
    int 10h 
    ;������play_msgд�� 
    mov ah,09 
    lea dx,play_msg 
    int 21h 
     
    inmunuloop: 
        mov ah,07 ;���������޻���
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
;init����������ڳ���ʼ����ʱ�����������õ� 
;ÿ�γ������л���������¿�ʼʱ�����һ�� 
init proc near ;����ʮ��
    push ax 
    push bx 
    push cx 
    push dx 
    push si ;Դ����
    push di ;Ŀ������
     
    mov exitflag,1;������¼���ʲôʱ��Ҫ�˳���Ϸ����Ϊ0ʱ�˳� 
    mov stopflag,0;���ڼ�¼ʲôʱ����ͣ�������1����ͣ 
    mov replayflag,0;���ڼ�¼�Ƿ����¿��֣�1Ϊ��Ч 
    mov propflag,-1;�����жϵ�ǰ��Ļ���Ƿ��е��ߣ����û����Ϊ-1������Ϊ��Ӧ�ĵ�0��n������ 
    mov speedflag,0;�����ж��Ƿ�Ҫ����,���Ϊ1��Ϊ���� 
    mov cmpgameflag,0;������¼��Ϸ�е�����ש���Ƿ���꣬������꣬��Ϊ1 
    mov balldeadflag,0;���ڼ�¼��С�������� 
     
    mov count,0;���������������¼������ 
    mov life_num,3;���������������¼����ֵ�� 
    mov score_num,0;�÷��ܺͲ��ܴ���255 
    mov mouse_last,80;���ڼ�¼��һ�εĵ�����λ�ã�ֻ��¼x�� 
    mov racket_width,30;���ڼ�¼���ĵĿ�� 
    mov ballx,90;������¼������Ͻǵ�x������ 
    mov bally,183;������¼������Ͻǵ�y������ 
    mov brick_num,100;������¼ש������� 
    mov x,1;���ڼ�¼�˶�����һ�� 
    mov y,-1;���ڼ�¼�˶��������� 
     
    mov al,frame_color;�߿���ɫ
    mov color,al;������ɫ 
    ;������ 
    mov qidianx,0 
    mov qidiany,0 
    mov zhongdianx,320 
    mov zhongdiany,2 
    call setarea ;����ʮ��
    ;����� 
    mov zhongdianx,3 
    mov zhongdiany,200 
    call setarea 
    ;���ײ� 
    mov qidianx,0 
    mov qidiany,197 
    mov zhongdianx,320 
    mov zhongdiany,200 
    call setarea 
    ;���ұ� 
    mov qidianx,317 
    mov qidiany,0 
    call setarea 
    ;���м�ķָ��� 
    mov qidianx,203 
    mov qidiany,2 
    mov zhongdianx,206 
    mov zhongdiany,200 
    call setarea 
    ;���ұߵĵ�һ���ָ��� 
    mov qidianx,205 
    mov qidiany,30 
    mov zhongdianx,320 
    mov zhongdiany,32 
    call setarea 
    ;���ұߵĵڶ����ָ��� 
    mov qidiany,60 
    mov zhongdiany,62 
    call setarea 
    ;���ұߵĵ������ָ��� 
    mov qidiany,109 
    mov zhongdiany,111 
    call setarea 
    ;����������ұߵ�һ������ 
    mov ah,02 ;���ù��ѡ��
    mov bh,00 ;0ҳ
    mov dh,2 ;�е�λ��
    mov dl,26 ;�е�λ��
    int 10h 
    ;��scoreд�� 
    mov ah,09 
    lea dx,score_msg 
    int 21h 
    call score_screen ;����ʮ��
    ;����������ұߵڶ������� 
    mov ah,02 
    mov bh,00 
    mov dh,6 
    mov dl,26 
    int 10h 
    ;��lifeд�� 
    mov ah,09 
    lea dx,life_msg 
    int 21h 
    ;����ʼ������ֵд�� 
    mov ah,02 ;��ʾһ���ַ�
    mov dl,life_num 
    add dl,30h 
    int 21h 
    ;����������ұߵ��������� 
    mov ah,02 
    mov bh,00 
    mov dh,09 
    mov dl,28 
    int 10h 
    ;��propд�� 
    mov ah,09 
    lea dx,prop_msg 
    int 21h 
    ;����������ұߵ���������,д��ڶ��� 
    mov ah,02 
    mov bh,00 
    mov dh,11 
    mov dl,28 
    int 10h 
    ;��none_msgд�� 
    mov ah,09 
    lea dx,none_msg 
    int 21h 
     
    ;����������ұߵ��ĸ����� 
    mov ah,02 
    mov bh,00 
    mov dh,15 
    mov dl,27 
    int 10h 
    ;��hint1д��hint 
    mov ah,09 
    lea dx,hint_msg1 
    int 21h 
    ;������ƣ���esc��hint��ʾд�� 
    mov ah,02 
    mov bh,00 
    mov dh,18 
    mov dl,26 
    int 10h 
    mov ah,09 
    lea dx,hint_msg2 
    int 21h 
    ;������ƣ���space��hint��ʾд�� 
    mov ah,02 
    mov dh,20 
    mov dl,26 
    int 10h 
    mov ah,09 
    lea dx,hint_msg3 
    int 21h 
    ;������ƣ�����<r>��hint��ʾд�� 
    mov ah,02 
    mov dh,22 
    mov dl,26 
    int 10h 
    mov ah,09 
    lea dx,hint_msg4 
    int 21h 
     
    ;�����Ļ��� 
    mov dl,racket_color 
    mov color,dl 
    mov qidianx,80 
    mov zhongdianx,110 
    mov qidiany,193 
    mov zhongdiany,196 
    call setarea 
    ;����ʼ������ 
     
    ;��ש�黭����Ļ;��Ҫ�����ݻ�ԭ 
    mov cx,brick_num;�õ�ש������� 
    mov si,-1;Ϊ�˷���ѭ�� 
    
	cmp barflag,1 ;���ڼ�¼�ǵڼ��أ�һ����5��
	jnz MY_ADDR2 
init_brick_huanyuan1:   ;���ѭ����Ϊ�˻�ԭ���ݵģ���Ҫ���������������ʱ 
    add si,1 
    mov al,brick_life_huanyuan1[si];������һһ��ԭ 
    mov brick_life[si],al 
    loop init_brick_huanyuan1 
    jmp huanyuan_end 
MY_ADDR2: 
    
    cmp barflag,2
    jnz MY_ADDR3	
init_brick_huanyuan2:   ;���ѭ����Ϊ�˻�ԭ���ݵģ���Ҫ���������������ʱ 
    add si,1 
    mov al,brick_life_huanyuan2[si];������һһ��ԭ 
    mov brick_life[si],al 
    loop init_brick_huanyuan2 
    jmp huanyuan_end 
MY_ADDR3: 
    
    cmp barflag,3
    jnz MY_ADDR4
init_brick_huanyuan3:   ;���ѭ����Ϊ�˻�ԭ���ݵģ���Ҫ���������������ʱ 
    add si,1 
    mov al,brick_life_huanyuan3[si];������һһ��ԭ 
    mov brick_life[si],al 
    loop init_brick_huanyuan3 
    jmp huanyuan_end 
MY_ADDR4:
    
    cmp barflag,4
    jnz MY_ADDR5
init_brick_huanyuan4:   ;���ѭ����Ϊ�˻�ԭ���ݵģ���Ҫ���������������ʱ 
    add si,1 
    mov al,brick_life_huanyuan4[si];������һһ��ԭ 
    mov brick_life[si],al 
    loop init_brick_huanyuan4 
    jmp huanyuan_end 
MY_ADDR5: 
    
    cmp barflag,5
    jnz MY_ADDR6
init_brick_huanyuan5:   ;���ѭ����Ϊ�˻�ԭ���ݵģ���Ҫ���������������ʱ 
    add si,1 
    mov al,brick_life_huanyuan5[si];������һһ��ԭ 
    mov brick_life[si],al 
    loop init_brick_huanyuan5 
    jmp huanyuan_end 
MY_ADDR6: 
         
huanyuan_end:      
    mov si,-1;�����ǽ���ԭ���ש����ʾ����Ļ�� 
    mov di,0 
    mov qidianx,4;��һ��ש������ϽǺ����½ǵ����� 
    mov zhongdianx,22 
    mov qidiany,3 
    mov zhongdiany,8 
     
init_brick:    ;���ڽ�ש�黭�� 
    add si,1 
    add di,1 
    cmp si,brick_num;��������е�ש���Ѿ����������� 
    je init_brick_exit 
    
    mov al,brick_color1;���������ש�� 
    cmp brick_life[si],1 
    je init_brick_color 
         
    mov al,brick_color2;�������ͨש�� 
    cmp brick_life[si],2 
    je init_brick_color 
         
    mov al,brick_color3;�����Ӳ��ש�� 
init_brick_color: 
    mov color,al;��Ҫ����ש����ɫ�͸�color 
    call setarea;���ú���ʮ�� 
 
    cmp di,10;�ж��Ƿ�һ�л��� 
    jne brick_x 
    
        mov di,0;���һ�л�����y���ֵҲ�仯��diҲҪ��0 
        add zhongdiany,7 
        add qidiany,7 
        mov qidianx,-16;Ϊ�˷���ѭ�������ｫx��ֵ���踺ֵ���������add������ 
        mov zhongdianx,2 
    brick_x:    ;��x��ֵ���ӣ�����һ��ש�� 
        add qidianx,20 
        add zhongdianx,20 
    jmp init_brick 
init_brick_exit:    ;ש�黭�� 
    pop di 
    pop si 
    pop dx 
    pop cx 
    pop bx 
    pop ax 
ret 
init endp 


;********************************************************************** 
;���µĴ�������������
GENSOUND  PROC NEAR ;������ʮ
          PUSH AX 
          PUSH BX 
          PUSH CX 
          PUSH DX 
          PUSH DI;Ŀ������
          MOV AL,0B6H;������
          OUT 43H,AL 
          MOV DX,12H 
          MOV AX,533H*2 ;AXΪ����
          DIV DI 
          OUT 42H,AL ;��λ�ֽ�
          MOV AL,AH 
          OUT 42H,AL  ;��λ�ֽ�
          IN AL,61H ;��ö˿�B�ĵ�ǰ����
          MOV AH,AL ;����
          OR AL,3 ;ʹPB0=1��PB1=1
          OUT 61H,AL ;��������
WAIT1:    MOV CX,8FF0H ;ʱ��36848��
DELAY1:   LOOP DELAY1 ;DEC CX    JNZ DELAY1
          DEC BX 
          JNZ WAIT1 
          MOV AL,AH ;��ö˿�B�ĳ�ʼ����
          OUT 61H,AL ;�ر�������
          POP DI ;Ŀ������
          POP DX 
          POP CX 
          POP BX 
          POP AX 
          RET 
GENSOUND  ENDP 

MUSIC2    PROC NEAR ;������ʮһ
          LEA SI,MUS_FREG2 ;ȡƫ�Ƶ�ַ
          LEA BP,DS:MUS_TIME2 ;ȡƫ�Ƶ�ַ
FREG2:    MOV DI,[SI] ;��DS:SI�е������Ƶ�DI
          CMP DI,-1 
          JE END_MUS2 
          MOV DX,DS:[BP] ;��DS:BP�е������Ƶ�DX
          MOV BX,1400 
          CALL GENSOUND 
          ADD SI,2 
          ADD BP,2 
FREG1:    MOV DI,[SI] ;��DS:SI�е������Ƶ�DI
          CMP DI,-1 
          JE END_MUS2 
          MOV DX,DS:[BP] ;��DS:BP�е������Ƶ�DX
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

