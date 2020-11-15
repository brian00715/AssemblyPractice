DATA SEGMENT
      DATE0 DB 'THE DATE IS:  '          ;日期
	  DATE1 DB 4 dup(0),'-'           ;年份
	  DATE2 DB 2 dup(0),'-'            ;月份
	  DATE3 DB 2 dup(0),10,13,'$'       ;日
	  YEAR DW 0
	  MONTH DB 0
	  DAY DB 0
	  
	  TIMEX0 db 'THE TIME IS:  '             ;时间
	  TIMEX1 DB 2 DUP(0),':'                ;小时
	  TIMEX2 DB 2 DUP(0),':'                ;分钟
	  TIMEX3 DB 2 DUP(0),10,13,'$'          ;秒钟
	  HOUR DB 0
	  MINUTE DB 0
	  SECOND DB 0
	  
	  COUNTER0 DB 'THE STOPWATCH:'         ;计时器
	  COUNTER1 DB 2 DUP(0),':'
	  COUNTER2 DB 2 DUP(0),':'
	  COUNTER3 DB 2 DUP(0),'$'
	  SWHOUR DB 0                                         ;计时器小时
	  SWMINUTE DB 0                                    ;计时器分钟
	  SWSECOND DB 0                                    ;计时器秒钟
	  STOPWATCH DB 'THE STOPWATCH:00:00:00 $'

	  ZIFU DB 0                ;键盘输入字符

	  STUDENT DB 'Student: WANGYI '
	  NUMBER DB ' Numner: 2016211686 '
	  CLASS  DB ' Class: 2016211401 '
	  LIFE DB ' Life Is Fantastic$'
	  SPACEB DB '                                                             $'

	  SHUOM1 DB ' Press   J   To Start the stopwatch $'             ;说明
	  SHUOM2 DB ' Press   I   To Reset the stopwatch $'
	  SHUOM3 DB ' Press SPACE To Stop  the stopwatch $'
	  SHUOM4 DB ' Press   Q   To Exit  program  $'

	  COLOR DB 70H     ;颜色变化
	  COLOR2 DB 00H     ;
	  XLABEL DW 1700H  ;坐标变化
	  ZJFLAG DB 0      ; 增减标志 0 增 1 减
	 

	  ZJFLAG2 DB 0      ;坐标变化标志0增1减
	  ZJFLAG3 DB 0      ;0  1 2
	   

	   
DATA ENDS

CODE SEGMENT PUBLIC
      ASSUME CS:CODE,DS:DATA
	  ORG 100H


;******************主程序*******************

 START: 
   BEGIN:
      MOV AX,DATA
	  MOV DS,AX
	  CALL CLEAR   ;清屏
	
	  
	  MOV AX,0600H           ; 设置背景色为白，前景色为黑     
	  MOV BX,7000H
	  MOV CX,0000H
	  MOV DX,074FH
	  INT 10H

 PLAY:
      CMP ZIFU,'Q'         ;字符输入为Q(QUIT)结束程序
	  JE ENDDDD

	  CALL PDATE
	  CALL PTIME
	  CALL INSTRU
	  CALL INFO
	  

INPUT:             ;键盘输入
      MOV AH,0BH    ;调用0b号功能   
	  INT 21H
	  CMP AL,0      ;键盘无输入，判断上一个字符
	  JE JUDGE      ;跳转到判断输入的字符
	  MOV AH,00H
	  INT 16H
	  MOV ZIFU,AL   ;判断输入的字符
	  JMP JUDGE

SWSTART:                
      CALL CLOCK          ;调用计时器
	  ;CALL XIANSHI
	  CALL XIANSHI2
      JMP ADTIME

JUDGE:
      CMP ZIFU,20H    ;输入空格跳转至计时器，计时器中字符输入为空格，计时器将暂停
	  JE SWSTART 
      CMP ZIFU,'J'    ;输入j 计数器开始
	  JE  SWSTART     ;计时器开始
	  CMP ZIFU,'I'    ;输入I进行计时器清零
	  CALL RESET  


 ADTIME:           ;调整显示的时间
      MOV AH,2CH   ;获得现在时间
	  INT 21H
	  CMP DH,SECOND ;与现在时间比较
	  JNZ PLAY      ;若不等就重新显示下一秒
	  JMP ADTIME    ;相等就继续比较

	  MOV AX,0200H       ;调整光标位置
	  MOV BX,0000H
	  MOV CX,0000H
	  MOV DX,1000H
	  INT 10H

ENDDDD:
      CALL CLEAR

	  MOV AX,0200H
	  MOV BX,0000H
	  MOV CX,0000H
	  MOV DX,0002H
	  INT 10H
	  MOV AH,4CH
	  INT 21H


;子程序

 ;************清屏***************

CLEAR PROC
  MOV AX,0600H                
	  MOV BX,0754H
	  MOV CX,0000H
	  MOV DX,2479H
	  INT 10H
CLEAR ENDP

;*************转换成ascll码**********

ASCII PROC               
        MOV DI,10
	    CMP AX,10
	    JL NEXTA
  NEXT:
        XOR DX,DX
	    DIV DI
	    ADD DX,'0'
	    DEC BX
	    MOV [BX],DL
	    OR AX,AX
	    JNZ NEXT
	    JMP NEXTB
 NEXTA:
	    ADD AL,30H
	    DEC BX
	    MOV [BX],AL
	    MOV AL,'0'
	    DEC BX
	    MOV [BX],AL
  NEXTB:
	    RET
ASCII ENDP

;***********************打印日期************************

PDATE PROC            
      MOV AX,0200H
	  MOV BX,0000H
	  MOV CX,0000H
	  MOV DX,0203H            ;调整光标位置
	  INT 10H
	  
	  MOV AX,0600H            ;调整字符颜色
	  MOV BX,7000H
	  MOV CX,0203H
	  MOV DX,0220H
	  INT 10H
	  
	  MOV AH,2AH                 ;调用中断获取当前日期
	  INT 21H
	  MOV WORD PTR YEAR,CX
	  MOV BYTE PTR MONTH,DH
	  MOV BYTE PTR DAY,DL
	  
	  MOV BX,OFFSET DATE1+4       ;年份
	  XOR AX,AX
	  MOV AX, WORD PTR YEAR
	  CALL ASCII
	  
	  MOV BX,OFFSET DATE2+2    ;月份
	  XOR AX,AX
	  MOV Al, BYTE PTR MONTH
	  CALL ASCII
	  
	  MOV BX,OFFSET DATE3+2
	  XOR AX,AX
	  MOV Al, BYTE PTR DAY
	  CALL ASCII
	   
	   MOV DX,OFFSET DATE0
	   MOV AH,09H
	   INT 21H
	   RET
PDATE ENDP

 ;***********************打印时间**************************

PTIME PROC                  
      MOV AX,0200H           ;光标位置
	  MOV BX,0000H
	  MOV CX,0000H
	  MOV DX,0303H
	  INT 10H

	  MOV AX,0600H            ;COLOR
	  MOV BX,7000H
	  MOV CX,0303H
	  MOV DX,0320H
	  INT 10H

	  MOV AH,2CH               ;获得当前时间
	  INT 21H
	  MOV BYTE PTR HOUR,CH
	  MOV BYTE PTR MINUTE,CL
	  MOV BYTE PTR SECOND,DH


	  MOV BX,OFFSET TIMEX1+2
	  XOR AX,AX
	  MOV AL,BYTE PTR HOUR
	  CALL ASCII

	  MOV BX,OFFSET TIMEX2+2
	  XOR AX,AX
	  MOV AL,BYTE PTR MINUTE
	  CALL ASCII

	  MOV BX,OFFSET TIMEX3+2
	  XOR AX,AX
	  MOV AL,BYTE PTR SECOND
	  CALL ASCII

	  MOV DX,OFFSET TIMEX0     ;显示
	  MOV AH,9H
	  INT 21H
	  RET
PTIME ENDP

;**************计时器****************
 
 CLOCK PROC
       MOV AX,0200H       ;光标位置
	   MOV BX,0000H
	   MOV CX,0000H
	   MOV DX,0403H
	   INT 10H

	   MOV AX,0600H            ;COLOR
	   MOV BX,7000H
	   MOV CX,0403H
	   MOV DX,0420H
	   INT 10H

	   CMP ZIFU,20H     ;ZIFU与空格比较，若是则暂停计时
	   JE  NEXTC
	   INC SWSECOND    ;设置进位
	   CMP SWSECOND,60
	   JNZ NEXTC
	   MOV SWSECOND,0
	   INC SWMINUTE
	   CMP SWMINUTE,60
	   JNZ NEXTC
	   MOV SWMINUTE,0
	   INC SWHOUR
	NEXTC:            ;显示计时器时间
	   NOP
	   MOV BX,OFFSET COUNTER1+2
	   XOR AX,AX
	   MOV AL,BYTE PTR SWHOUR
	   CALL ASCII

	   MOV BX,OFFSET COUNTER2+2
	   XOR AX,AX
	   MOV AL,BYTE PTR SWMINUTE
	   CALL ASCII

	   MOV BX,OFFSET COUNTER3+2
	   XOR AX,AX
	   MOV AL,BYTE PTR SWSECOND
	   CALL ASCII

	   MOV DX,OFFSET COUNTER0
	   MOV AH,09H
	   INT 21H

	   RET
CLOCK ENDP

;**************计时器清零**********
RESET PROC
       MOV AX,0200H       ;光标位置
	   MOV BX,0000H
	   MOV CX,0000H
	   MOV DX,0403H
	   INT 10H

	   MOV AX,0600H            ;COLOR
	   MOV BX,7000H
	   MOV CX,0403H
	   MOV DX,0420H
	   INT 10H
       
	   MOV SWHOUR,0
	   MOV SWMINUTE,0
	   MOV SWSECOND,0

	   MOV DX,OFFSET STOPWATCH
	   MOV AH,09H
	   INT 21H
	   RET 
RESET ENDP

;*************说明显示颜色变化***********
INSTRU PROC
       
	  MOV AX,0200H
	  MOV BX,0000H
	  MOV CX,0000H
	  MOV DX,0227H            ;调整光标位置
	  INT 10H
	  
	  MOV AX,0600H            ;调整字符颜色
	  MOV BH,COLOR
	  MOV CX,0227H
	  MOV DX,024FH
	  INT 10H

	  MOV DX,OFFSET SHUOM1
	  MOV AH,09H
	  INT 21H

	  MOV AX,0200H
	  MOV BX,0000H
	  MOV CX,0000H
	  MOV DX,0327H            ;调整光标位置
	  INT 10H
	  
	  MOV AX,0600H            ;调整字符颜色
	  MOV BH,COLOR
	  MOV CX,0327H
	  MOV DX,034FH
	  INT 10H

	  MOV DX,OFFSET SHUOM2
	  MOV AH,09H
	  INT 21H

	  MOV AX,0200H
	  MOV BX,0000H
	  MOV CX,0000H
	  MOV DX,0427H            ;调整光标位置
	  INT 10H
	  
	  MOV AX,0600H            ;调整字符颜色
	  MOV BH,COLOR
	  MOV CX,0427H
	  MOV DX,044FH
	  INT 10H

	  MOV DX,OFFSET SHUOM3
	  MOV AH,09H
	  INT 21H

	  MOV AX,0200H
	  MOV BX,0000H
	  MOV CX,0000H
	  MOV DX,0527H            ;调整光标位置
	  INT 10H
	  
	  MOV AX,0600H            ;调整字符颜色
	  MOV BH,COLOR
	  MOV CX,0527H
	  MOV DX,054FH
	  INT 10H

	  MOV DX,OFFSET SHUOM4
	  MOV AH,09H
	  INT 21H

   
	ZENG:
	   INC COLOR
	   CMP COLOR,7FH
	   JE FUWEI
	   JMP ENDAA
	FUWEI:
	   MOV COLOR,70H
	   JE ZENG
	ENDAA:
	   RET
INSTRU ENDP
;*****************姓名学号显示（坐标变化）******
INFO PROC 
     
	  DEC XLABEL
      MOV AX,0200H
	  MOV BX,0000H
	  MOV CX,0000H
	  MOV DX,XLABEL            ;调整光标位置
	  INT 10H
	  
	  MOV AX,0600H            ;调整字符颜色
	  MOV BX,0700H
	  MOV CX,1700H
	  MOV DX,174FH
	  INT 10H

	  MOV DX,OFFSET SPACEB     ; 清前一次的窗口
	  MOV AH,09H
	  INT 21H

	  INC XLABEL
      MOV AX,0200H
	  MOV BX,0000H
	  MOV CX,0000H
	  MOV DX,XLABEL            ;调整光标位置
	  INT 10H
	  
	  MOV AX,0600H            ;调整字符颜色
	  MOV BX,0700H
	  MOV CX,1700H
	  MOV DX,174FH
	  INT 10H

	  MOV DX,OFFSET STUDENT
	  MOV AH,09H
	  INT 21H

	  CMP ZJFLAG,1
	  JE  XJIAN
	XZENG:                ; 坐标调整
	   INC XLABEL 
	   CMP XLABEL,1707H
	   JNE ENDBB
	   MOV ZJFLAG,1
	   JMP ENDBB
	XJIAN:
	   DEC XLABEL
	   CMP XLABEL,1700H
	   JNE ENDBB
	   MOV ZJFLAG,0

	ENDBB:
	   RET
INFO ENDP
 ;***********显示***********
 XIANSHI PROC

      MOV AX,0600H                
	  MOV BH,COLOR2
	  MOV CX,0800H
	  MOV DX,154FH
	  INT 10H


	  CMP ZIFU,20H   ;空格输入暂停
	  JE ENDEE

	  CMP ZJFLAG3,1
	  JE COLORJ
  COLORZ:
      ADD COLOR2,10H
	  CMP COLOR2,0E0H
	  JNE ENDEE
	  MOV ZJFLAG3,1
	  JMP ENDEE
  COLORJ:
      SUB COLOR2,10H
	  CMP COLOR2,00H
	  JNE ENDEE
	  MOV ZJFLAG,0
  ENDEE:
      RET
XIANSHI ENDP  
; **************显示2**********
XIANSHI2 PROC
     
	  MOV AX,0600H                
	  MOV BH,0000H
	  MOV CX,0800H
	  MOV DX,154FH
	  INT 10H
	  
	  CMP ZIFU,20H   ;空格输入暂停
	  JE ENDF

	  CMP ZJFLAG3,0
	  JE HONG
	  CMP ZJFLAG3,1
	  JE LV
	  CMP ZJFLAG3,2
	  JE HUANG
   HONG:	
      MOV AX,0600H                
	  MOV BH,40H
	  MOV CX,0E0FH
	  MOV DX,1117H
	  INT 10H 
	  INC ZJFLAG3
	  JMP ENDF
   LV:
      MOV AX,0600H                
	  MOV BH,20H
	  MOV CX,0E1FH
	  MOV DX,1127H
	  INT 10H
	  INC ZJFLAG3
	  JMP ENDF
	HUANG:
	  MOV AX,0600H                
	  MOV BH,60H
	  MOV CX,0E2FH
	  MOV DX,1137H
	  INT 10H
	  MOV ZJFLAG3,0
	  JMP ENDF
	ENDF:
	  
	  RET
XIANSHI2 ENDP
	
CODE ENDS
END START
	  

	  
	  
	  
           
		   
