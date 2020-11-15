;**************************************************
   STACK SEGMENT PARA STACK 'STACK' 
         DB 128 DUP('STACK...') 
     STACK ENDS 
;************************************************** 
  DSEG SEGMENT PARA 'DATA' 
  flag db 0           ;标志位，用于上一首下一首的切换
  h    db '0'         ;速度标志
  o    dw 12H         ;音调标志位
  biaoji db 1         ;播放模式标记
 flagh db ?           
  MESS1 DB 5 DUP(' '),0DH,0AH,20 DUP(' '),'Now the music is <<Because of love>>','$' 
  MESS2 DB 5 DUP(' '),0DH,0AH,20 DUP(' '),'Now the music is <<Mary had a little lamb>>','$' 
  MESS3 DB 4 DUP(' '),0DH,0AH,20 DUP(' '),'Now the music is <<Jingle bell>>','$' 
  MESS4 DB 4 DUP(' '),0DH,0AH,20 DUP(' '),'please input the speed (s/q)','$' 
  MESS5 DB 4 DUP(' '),0DH,0AH,20 DUP(' '),'please input the yiliang (h/m/l)','$' 
  shun  DB 4 DUP(' '),0DH,0AH,20 DUP(' '),'Now is the order of play!','$'
  ni    DB 4 DUP(' '),0DH,0AH,20 DUP(' '),'Now is the reverse playback!','$'
  dan   DB 4 DUP(' '),0DH,0AH,20 DUP(' '),'Now is the single cycle!','$'
  sui   DB 4 DUP(' '),0DH,0AH,20 DUP(' '),'Now it is random!','$'
  MENU   DB 20 DUP(' '),'       Welcome to Music Player        ',13,10
  DB 20 DUP(' '),'**************MENU********************',13,10 
  DB 20 DUP(' '),'**1:Because of love                 **',13,10 
  DB 20 DUP(' '),'**2:Mary had a little lamb;         **',13,10
  DB 20 DUP(' '),'**3:Jingle bell                     **',13,10 
  DB 20 DUP(' '),'**4:Exit;                           **',13,10 
  DB 20 DUP(' '),'**********Function keys***************',13,10
  DB 20 DUP(' '),'**N:next  L:last  Z:pause J:continue**',13,10
  DB 20 DUP(' '),'**D:forward  A:Rewind               **',13,10
  DB 20 DUP(' '),'**X:speed+   K:speed-               **',13,10
  DB 20 DUP(' '),'**Q:Volume+  W:Volume-              **',13,10
  DB 20 DUP(' '),'**E:Single cycle  T:Order play      **',13,10
  DB 20 DUP(' '),'**Y:Random cycle  R:Reverse play    **',13,10
  DB 20 DUP(' '),'**C:Restart       U:next random     **',13,10
  DB 20 DUP(' '),'**Press any other key quit!         **',13,10       
  DB 20 DUP(' '),'********Support @20th group***********',13,10
  DB 20 DUP(' '),'please chioce the number of music:','$',13,10 
  change DB 125 DUP(' '),'error!  please change another word!: ','$' 
;*******************************************************************************************
;*                                                                                         *
;*                              《因为爱情》的乐曲表                                       *
;*                                                                                         *
;*******************************************************************************************

  MUS_FREG_m    dw 294,330,393,393,330,393,393,330,294 
                dw 393,393,393,441,495,525,525,525,495,525 
                dw 495,495,495,393,330,330,330,393,330,393 
                dw 441,441,393,441,393,393,262,262,262,221
                dw 262,330,294,221,330,294,221,441,393,393
                dw 294,330,393,393,330,330,393,393,330,294
                dw 393,393,393,441,495,525,525,525,495,525
                dw 525,495,495,495,393,330,330,330,393,330
                dw 393,441,441,441,393,441,441,393,393,262
                dw 262,262,221,262,330,294,221,330,294,221
                dw 330,294,294,294,330,294,330,330,262,262,262,262 
                dw -1 

  MUS_TIME_s    dw 250,125,125,125,125,125,125,125,125 
                dw 125,250,250,125,125,125,125,125,125,125 
                dw 125,125,125,125,125,250,250,125,125,125
                dw 125,250,250,125,125,125,125,250,250,125
                dw 125,125,125,125,125,125,125,250,250,250
                dw 250,125,125,125,125,250,250,125,125,125
                dw 125,250,250,125,125,125,125,125,125,125
                dw 50,125,125,125,125,125,250,250,125,125
                dw 125,125,250,50,250,125,50,125,125,125
                dw 250,250,125,125,125,125,125,125,125,125
                dw 125,125,250,250,250,125,125,125,125,250,250,250,250 
  MUS_TIME_q    dw 200,100,100,100,100,100,100,100,100 
                dw 100,200,200,100,100,100,100,100,100,100
                dw 100,100,100,100,100,200,200,100,100,100 
                dw 100,200,200,100,100,100,100,200,200,100
                dw 100,100,100,100,100,100,100,200,200,200
                dw 200,100,100,100,100,200,200,100,100,100
                dw 100,200,200,100,100,100,100,100,100,100
                dw 40,100,100,100,100,100,200,200,100,100
                dw 100,100,200,50,200,100,50,100,100,100
                dw 200,200,100,100,100,100,100,100,100,100
                dw 100,100,200,200,200,100,100,100,100,200,200,200,200
;*******************************************************************************************
;*                                                                                         *
;*                              <<Mary had a little lamb>>的乐曲表                         *
;*                                                                                         *
;*******************************************************************************************


  mus_freg1_m   dw 330,294,262,294,330,330,330 
                dw 294,294,294,330,392,392 
                dw 330,294,262,294,330,330,330,330 
                dw 294,294,330,294,262 
                dw  -1 

  mus_time1_s  dw 6 dup(300),500
               dw 2 dup(300,300,500) 
               dw 12 dup(300),900
  mus_time1_q  dw 6 dup(100),200 
               dw 2 dup(100,100,200)
               dw 12 dup(100),400 
;*******************************************************************************************
;*                                                                                         *
;*                                《铃儿叮当响》的乐曲表                                   *
;*                                                                                         *
;*******************************************************************************************


  mus_freg2_m dw 7 dup(330),392,262,294,330,4 dup(349),2 dup(330),330,294,294,262,294,392
              dw 7 dup(330),392,262,294,330,4 dup(349),2 dup(330),392,392,349,294,262 
              dw -1    

  mus_time2_s dw 2 dup(25*6,25*6,50*6),4 dup(25*6),10*60,2 dup(25*6,25*6,50*6)
              dw 4 dup(25*6),2 dup(50*6),2 dup(25*6,25*6,50*6)
              dw 4 dup(25*6),10*60,2 dup(25*6,25*6,50*6),4 dup(25*6),10*60
  mus_time2_q dw 2 dup(25*4,25*4,50*4),4 dup(25*4),10*40,2 dup(25*4,25*4,50*4)
              dw 4 dup(25*4),2 dup(50*4),2 dup(25*4,25*4,50*4)
              dw 4 dup(25*4),10*40,2 dup(25*4,25*4,50*4),4 dup(25*4),10*40
   DSEG ENDS 
;************************************************** 
   CODE SEGMENT PARA 'DATA' 
  assume cs:code,ds:dseg,ss:stack 
      f db 1          ;音调标志，记录音调
      t db 1          ;速度标志，记录选择速度
music proc far 
    mov ax,dseg 
    mov ds,ax
  rotate:
      mov f,'0'        ;重新运行时标志清零
      mov t,'0'
      mov biaoji,'t'
    LEA DX,MENU       ;显示菜单
    mov ah,9 
    int 21h 
    mov ah,1      
    int 21h
  chg:
    mov bx,12H        ;标志位重置
    mov o,bx          
    cmp al,'u'        ;下一首随机处理
    je sjbf
    mov h,'0'         ;重置标志位
    cmp al,'c'
    je cxks1          ;重播
    cmp al,'n'        ;判断是上一首还是下一首
    je next1           ;N键，下一首歌处理
    cmp al,'l'
    je last1          ;L键，上一首歌处理
    mov flag,al
    cmp al,'1'        ;选择歌曲
    je  one1          ;第一首歌处理程序
    cmp al,'2' 
    je  two1          ;第二首歌曲处理程序
    cmp al,'3'
    je three1         ;第三首处理程序
    cmp al,'4' 
    je  endmus1       ;退出 
      cmp al,'t'
      je chulit         ;顺序播放处理
      cmp al,'e'
      je chulie         ;单曲循环处理
      cmp al,'r'
      je chulir         ;逆序循环处理
      cmp al,'y'
      je chuliy         ;随机播放处理
    LEA DX,change     ;如果没有对应的，返回 
    mov ah,09 
    int 21h
    jmp rotate 
  cxks1: jmp cxks      ;中继跳转
  next1: jmp next      ;中继跳转
  last1:  jmp last     ;中继跳转
  one1:jmp one         ;中继跳转
  two1:jmp two2        ;中继跳转
  three1:jmp three2    ;中继跳转
  endmus1:jmp endmus   ;中继跳转
  sjbf: mov ah,2ch     ;随机播放处理程序
      int 21h
      mov ah,0
      mov al,dl
      mov dh,03h
      div dh
      cmp ah,00h
      je ji0
      cmp ah,01h
      je ji1
      cmp ah,02h
      je ji2
  ji0: mov flag,'1'
      jmp next
  ji1: mov flag,'2'
      jmp next
  ji2: mov flag,'3'
      jmp next
  chulit:             
      lea dx,shun
      mov ah,09
      int 21h
      jmp chuliall
  chulir:             
      lea dx,ni
      mov ah,09
      int 21h
      jmp chuliall
  chulie:
      lea dx,dan
      mov ah,09
      int 21h
      jmp chuliall
  chuliy:
      lea dx,sui
      mov ah,09
      int 21h
      jmp chuliall
  chuliall:              ;播放模式处理
      mov biaoji,al        ;置al，回到主程序重新选择
      mov ah,01
      int 21h
      jmp chg
  cxks:                     ;重新开始处理
      dec flag
      cmp flag,'0'
      je chuli
      jmp next
  chuli:
      mov flag,'3'
      jmp next
  next:                ;下一首歌处理
    cmp flag,'1'       ;判断当前歌曲
    je  notwo          ;然后直接播放下一首歌
    cmp flag,'2'       ;默认音调和快慢
    je nothree
    cmp flag,'3'
    je noone
  last:                ;shang一首歌处理，原理同上
    cmp flag,'3'
    je  notwo
    cmp flag,'1'
    je nothree
    cmp flag,'2'
    je noone
  notwo:
      lea dx,mess2
    mov ah,09 
    int 21h
      mov flag,'2'
      cmp f,'h'
    je  two_h1
    CMP f,'m'
    JE  two_m1
    CMP f,'l'
    JE  two_l1
  noone:
      lea dx,mess1
    mov ah,09 
    int 21h
    mov flag,'1'
      cmp f,'h'
    je   one_h1
    CMP f,'m'
    JE  one_m1
    CMP f,'l'
    JE  one_l1
  nothree:
      lea dx,mess3
  mov ah,09 
    int 21h
    mov flag,'3'
      cmp f,'h'
    je   three_h1
    CMP f,'m'
    JE  three_m1
    CMP f,'l'
    JE  three_l1
  one_h1: jmp one_h
  one_m1: jmp one_m
  one_l1: jmp one_l
  two_h1: jmp two_h
  two_m1: jmp two_m
  two_l1: jmp two_l
  three_h1: jmp three_h
  three_m1: jmp three_m
  three_l1: jmp three_l
  three2:jmp zhong     ;中继跳转   
  two2:jmp two         ;中继跳转 
  ENDMUS:              ;退出
    mov ax,4c00h 
    int 21h 
  ONE:                 ;第一首歌处理
    lea dx,mess1 
    mov ah,09 
    int 21h 
  yindiao:lea dx,mess5 ;选择音调 
    mov ah,09 
    int 21h 
    mov ah,01 
    int 21h 
    mov f,al
    cmp al,'h' 
    je one_h 
    cmp al,'m' 
    je one_m 
    cmp al,'l' 
    je one_l 
    jmp yindiao

  ZHONG:JMP three        ;中继跳转
  sudu: lea dx,mess4   ;选择速度 
    mov ah,09 
    int 21h 
    mov ah,01 
    int 21h 
    mov t,al
    cmp al,'s' 
    je one_s 
    cmp al,'q' 
    je one_q 
    jmp sudu
  one_h:
mov flagh,'1'
LEA SI,mus_FREG_m   ;装入频率表和时间表 
    CMP t,'s'
    JE  ONE_S
    CMP t,'q'
    JE  ONE_Q
    jmp sudu 
  one_m:
mov flagh,'2'
LEA SI,MUS_FREG_m 
    CMP t,'s'
    JE  ONE_S
    CMP t,'q'
    JE  ONE_Q
    jmp sudu  
  one_l:
mov flagh,'3'
LEA SI,MUS_FREG_m 
    CMP t,'s'
    JE  ONE_S
    CMP t,'q'
    JE  ONE_Q
    jmp sudu 
  one_s:LEA BP,DS:MUS_TIME_s
    JMP SOUND 
  one_q:LEA BP,DS:MUS_TIME_q 
    JMP SOUND
  two:                     ;第二首歌处理程序
    lea dx,mess2           ;原理同上 
    mov ah,09 
    int 21h 
  yindiao1:lea dx,mess5 
    mov ah,09 
    int 21h 
    mov ah,01 
    int 21h 
    mov f,al
    cmp al,'h' 
    je two_h 
    cmp al,'m' 
    je two_m 
    cmp al,'l' 
    je two_l
    JMP yindiao1 
  sudu1: lea dx,mess4
    mov ah,09 
    int 21h 
    mov ah,01 
    int 21h 
    mov t,al
    cmp al,'s' 
    je two_s 
    cmp al,'q' 
    je two_q 
    jmp sudu1
  two_h:   
mov flagh,'1'
 LEA SI,mus_FREG1_m 
    cmp t,'s'
    je   two_s
    CMP t,'q'
    JE  two_q
    jmp sudu1 
  two_m:   
mov flagh,'2'
 LEA SI,MUS_FREG1_m 
    CMP t,'s'
    JE  two_S
    CMP t,'q'
    JE  two_Q
    jmp sudu1  
  two_l:   
mov flagh,'3'
 LEA SI,MUS_FREG1_m 
    CMP t,'s'
    JE  two_S
    CMP t,'q'
    JE  two_Q
    jmp sudu1 
  two_s:    LEA BP,DS:MUS_TIME1_s    
    JMP SOUND 
  two_q:   LEA BP,DS:MUS_TIME1_q    
    JMP SOUND
  three:
    lea dx,mess3 
    mov ah,09 
    int 21h 
  yindiao2:lea dx,mess5 
    mov ah,09 
    int 21h 
    mov ah,01 
    int 21h 
    mov f,al
    cmp al,'h' 
    je three_h 
    cmp al,'m' 
    je three_m 
    cmp al,'l' 
    je three_l
    jmp yindiao2 
  sudu2: lea dx,mess4 
    mov ah,09 
    int 21h 
    mov ah,01 
    int 21h 
    mov t,al
    cmp al,'s' 
    je three_s 
    cmp al,'q' 
    je three_q 
    jmp sudu2
  three_h: mov flagh,'1'
  LEA SI,mus_FREG2_m    
    CMP t,'s'
    JE  three_s
    CMP t,'q'
    JE  three_q
    jmp sudu2 
  three_m:   
mov flagh,'2'
 LEA SI,MUS_FREG2_m 
      CMP t,'s'
    JE  three_s
    CMP t,'q'
    JE  three_q 
    jmp sudu2 
  three_l:  
mov flagh,'3'
  LEA SI,MUS_FREG2_m 
    CMP t,'s'
    JE  three_s
    CMP t,'q'
    JE  three_q
    jmp sudu2 
  three_s:    LEA BP,DS:MUS_TIME2_s
    JMP SOUND 
  three_q:   LEA BP,DS:MUS_TIME2_q
    JMP SOUND
  sound3:
    add si,6
    add bp,6
    jmp sound
  sound4:
    sub si,4
    sub bp,4
    jmp sound
  SOUND:                ;发声主程序
  freq: 
    mov di,[si] 
    cmp di,-1           ;判断是否到曲末
    je  rr
    call printf
    mov bx,ds:[bp] 
    mov ah,00bh         ;判断播放时是否有按键
    int 21h             
    cmp al,0ffh
    je n                ;如果有，跳出音乐播放
 n5:call soundf
    add si,2 
    add bp,2
    jmp freq

  n:                    ;按键处理
      mov ah,07
      int 21h
    cmp al,'x'          ;快播功能
    je n1
    cmp al,'k'          ;结束快播/正常
    je n3
    cmp al,'q'          ;音调++
    je n8
    cmp al, 'j'         ;继续
    je sound
    cmp al,'z'          ;暂停
      je n
    cmp al,'d'          ;快进
    je sound3    
    cmp al,'a'          ;快退
    je sound4
    cmp al,'t'          ;顺序播放
      je sx
      cmp al,'e'          ;单曲循环
      je dandan
      cmp al,'r'          ;逆序循环
      je nx
      cmp al,'y'          ;随机播放
      je sj
      cmp al,'w'          ;音调--
    je n9
    jmp chg             ;其他功能键处理
  rr: jmp r
  sx: mov biaoji,al            
      lea dx,shun
      mov ah,9
      int 21h
    jmp freq
  nx: mov biaoji,al
      lea dx,ni
      mov ah,9
      int 21h
    jmp freq
  dandan: mov biaoji,al
      lea dx,dan
      mov ah,9
      int 21h
    jmp freq
  sj: mov biaoji,al
      lea dx,sui
      mov ah,9
      int 21h
    jmp freq
  n1:mov h,'1'
    jmp n5
  n3:mov h,'0'
    jmp n5    
  n8:mov bx,o  ;改动位置
    add bx,02h
    mov o,bx
    jmp n5
  n9:mov bx,o 
    cmp o,2
    je n6 ;改动位置
    sub bx,02h
    mov o,bx
    jmp n5
n6:mov bx,2
   mov o,bx
   jmp n5
      
  r:cmp biaoji,'t'     ;播放模式选择
      je shunxu
      cmp biaoji,'e'
      je danqu
      cmp biaoji,'r'
      je daoxu
      cmp biaoji,'y'
      je suiji 
  shunxu:mov al,'n' 
      JMP chg
  daoxu:mov al,'l' 
      JMP chg
  danqu:mov al,'c' 
      JMP chg
  suiji:mov al,'u' 
      JMP chg
music endp 
;*************************************************** 
soundf  proc near       ;发声子程序
        push    ax 
        push    bx 
        push    cx 
        push    dx 
        push    di 
        mov     al,0b6h  ;根据频率和时间
        out     43h,al    ;输出到蜂鸣器
cmp flagh,'1'
je flagh1
cmp flagh,'2'
je flagh2
cmp flagh,'3'
je flagh3
jmp flagh4
flagh1:
 mov     dx,02h
jmp flagh4
flagh2:
 mov     dx,06h
jmp flagh4
flagh3:
 mov     dx,12h
jmp flagh4
flagh4: 
            ;音调控制变量，被除数初值 
        mov     ax,348ch 
        div     di 
        out     42h,al 
        mov     al,ah 
        out     42h,al 
        in      al,61h 
        mov     ah,al 
        or      al,3 
        out     61h,al 
        cmp h,'0'
        je wait1
        cmp h,'1'
        je wait2
         
  wait1:cmp h,'0'         ;速度控制，不同的延迟计数初值 
        jne delay  
        mov cx,1500
        call    waitf 
  wait2:cmp h,'1'
        jne delay  
        mov cx,1000
        call    waitf
delay:                   ;延时程序
        loop    delay 
        dec     bx 
        jnz     wai
        mov     al,ah 
        out     61h,al   
        pop     di 
        pop     dx 
        pop     cx 
        pop     bx 
        pop     ax 
        ret 
soundf  endp 
   wai:cmp h,'0'
       je wait1
       cmp h,'1'
       je wait2
waitf  proc near
       push    ax 
waitf1: in      al,61h 
       and     al, 10h 
       cmp    al, ah 
       je      waitf1 
       mov    ah,al 
       loop    waitf1 
       pop     ax         
 ret 
waitf   endp
printf  proc near        ;音符打印子程序
          cmp di,131
          je t1
          cmp di,147
          je t2
          cmp di,165
          je t3
          cmp di,175
          je t4
          cmp di,196
          je t5
          cmp di,221
          je t6
          cmp di,248
          je t7
          cmp di,262
          je t1
          cmp di,294
          je t2
          cmp di,330
          je t3
          cmp di,350
          je t4
          cmp di,393
          je t5
          cmp di,441
          je t6
          cmp di,495
          je t7
          cmp di,525
          je t1
          cmp di,589
          je t2
          cmp di,661
          je t3
          cmp di,700
          je t4
          cmp di,786
          je t5
          cmp di,882
          je t6
          cmp di,990
          je t7
          ret
t1:       mov dx,'1'
          jmp tto3
t2:       mov dx,'2'
          jmp tto3
t3:       mov dx,'3'
          jmp tto3  
t4:       mov dx,'4'
          jmp tto3                 
t5:       mov dx,'5'
          jmp tto3
t6:       mov dx,'6'
          jmp tto3
t7:       mov dx,'7'
          jmp tto3 
           ret   
tto3:     mov ah,02h
          int 21h 
          ret
printf  endp 
;*************************************************** 
  code ends 
  end music