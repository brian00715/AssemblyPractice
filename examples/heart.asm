data segment
full db 0
									;第一个界面文字消息
buff1 db                        ' God bless you !'
      db			0dh,0ah,'******Hello welcome******',0dh,0ah,'Please press any key*****$'
		 							;主界面文字消息
buff2 db            '       My heart beats with yours!'
      db '                 ***** Please q to quit *****$        '
data ends
stack segment stack   	        	;定义堆栈段
stack ends
code segment
main proc far
assume cs:code,ds:data
start:						 		;开始界面初始化
     push ds
     sub ax,ax
     push ax
     mov ax,data
     mov ds,ax
     mov ah,00				    	;设置显示方式为320*200彩色图形方式
     mov al,04
     int 10h
     mov ah,0bh
     mov bh,00			        	;利用BIOS调用的10H中断类型11号功能设定背景色
mov bl,1				        	;通过（b1）的赋值0—15设定颜色，此为蓝色	
int 10h
     mov ah,0bh			        	;设置彩色组
     mov bh,1
     mov bl,2
     int 10h
mov dx,offset buff1        	    	;显示提示信息，即buff1的字符串内容
  	mov ah,09
     int 21h
     mov ah,08				    	;从键盘输入1个字符，但不送显示器显示
     int 21h
     call clear                 	;清除所有显示，移至左上角
sss:					        	;贺卡文字消息消失
     call text                  	;显示文本信息            
     mov di,2			        	;绘制第一个大方块
     mov al,1                         
     mov cx,70			        	;显示点所在列号
     mov dx,20		   	        	;显示点所在行号
     mov bx,160		            	;确定方框大小
     call box			        	;调用画方框子程序
     mov cx,71 		   	        	;画方框移动轨迹，使方框变化看上去是移动的
     mov dx,21 
     mov bx,158
again:				     	    	;由大到小继续画方块
	 mov al,1
     mov di,0				    	;绘制第二个大方块
     call box				    	;调用延迟子程序
	 mov al,0				    	;位置初始化
     mov di,0
     call box				    	;调用画方框子程序
     inc cx			            	;每次轨迹图的行号是自加1，轨迹图是由大变小
     inc dx							;每次轨迹图的列号是自加1，使轨迹图由小变大
     sub bx,2			   	    	;设定每次轨迹图大小减小的程度
     cmp cx,94			   	    	;当轨迹方框大小与下一个方框相等时，退出画轨迹
     jnz again			     		;绘制第二个方块
     mov di,0                         
     mov cx,95						;确定行号
     mov dx,45						;确定列号
     mov al,1
     mov bx,110		      	    	;第二个方框较第一个方框较小
     call box						;调用画方框子程序，绘制出线条
     mov cx,96					
     mov dx,46    					;明确行列
     mov bx,108
again_00:				   	    	;重复刚才的操作
     mov al,1
     mov di,0
     call box						;调用画方框子程序
     call delay						;调用延迟子程序
     call delay						;调用延迟子程序
     mov al,0					
     mov di,0
     call box
     inc cx			       	    	;每次轨迹图的行号和列号是自加1，轨迹图是由大变小
     inc dx
    sub bx,2			   	    	;设定每次轨迹图大小减小的程度
     cmp cx,114			  	    	;当轨迹方框大小与下一个方框相等时，退出画轨迹
jnz again_00		      	    	;绘制第三个方块
     mov cx,115                       
     mov dx,65
     mov al,1
     mov bx,70			        	;第三个方框较前两个小方块
     call box
     mov cx,116
     mov dx,66
     mov bx,68
again_01:				        	;继续重复，画更小的方块
     mov al,1
     mov di,0
     call box						;调用画方框子程序，基本重复上一步骤操作，数值有所变动
     call delay						;调用延迟子程序
     call delay						;调用延迟子程序，保证出图的速度不太快
     mov al,0
     mov di,0
     call box						;调用画方框子程序
     inc cx			            	;每次轨迹图的行号是自加1
     inc dx							;每次轨迹图的列号是自加1，轨迹图是由大变小
     sub bx,2			        	;设定每次轨迹图大小减小的程度
     cmp cx,129		            	;当轨迹方框大小与下一个方框相等时，退出画轨迹
     jnz again_01					;跳转到again_01子程序
     mov di,2			        	;绘制最小的方块，此时不需要画轨迹图
     mov al,1                          
     mov cx,130						;确定列号
     mov dx,80						;确定行号	
     mov bx,40						;确定对角线
     call box 						;调用延迟子程序
     mov di,2			        	;对角线的绘制
     mov al,3                       
     mov si,0
     mov cx,71			        	;确定点所在列号
     mov dx,21			        	;确定点所在行号
     mov bx,59			        	;设置对角线长度
call xie_line		       		    ;调用画对角线子程序
     mov cx,171						;确定点所在列号
     mov dx,121						;确定点所在行号
     mov bx,59						;确定对角线长度
call xie_line		       			;十字线的绘制
     mov si,1
     mov cx,71						;十字线的列号
     mov dx,179						;十字线的行号
     mov bx,59						;以及其长度
call xie_line						;再次调用画对角线子程序
     mov cx,171						;反方向的列号
     mov dx,79						;反方向的行号
     mov bx,59						;长度与上方的相同
call xie_line						;十字线的绘制第三步
	 mov si,0				
     mov cx,150                		;画中间的横线的列号    
     mov dx,20						;确定点所在行号
     mov bx,60						;确定十字线长度
call draw_line						;调用画线子程序（下线）
     mov cx,150						;确定列号
     mov dx,120						;确定行号
     mov bx,60						;及其长度
call draw_line						;再次调用画线子程序
     mov cx,70						;画中间的一条线的列
     mov dx,100						;行
     mov si,1					
     mov bx,60						;线长度
call draw_line						;调用画线子程序（绘制上线）
     mov cx,170		    			;确定点所在列号
     mov dx,100		    			;确定点所在行号
     mov bx,60						;设置对角线长度
call draw_line						;调用画线子程序（绘制中线）
     mov si,1
     mov cx,70						;确定点所在列号
     mov dx,60						;确定点所在行号
	 mov bx,60						;设置对角线长度
	 
call mid_line					
 	 mov cx,170					
     mov dx,110
     mov bx,60
call mid_line						;绘制中线，继续重复上方操作（线1）
     mov si,2
     mov cx,110		    			;确定点所在列号
     mov dx,20						;确定点所在行号
     mov bx,30						;设置对角线长度
call mid_line						;绘制中线，（线2）
     mov cx,160						;确定点所在列号
     mov dx,120						;确定点所在行号
     mov bx,30						;设置对角线长度
call mid_line						;调用画中线子程序（线3）
     mov si,3
     mov cx,70						;确定点所在列号
     mov dx,140		    			;确定点所在行号
     mov bx,60						;设置对角线长度
call mid_line						;调用画中线子程序（线4）
     mov cx,170		    			;确定点所在列号
     mov dx,90						;确定点所在行号
     mov bx,60						;设置对角线长度
call mid_line						;依旧重复刚才操作;调用画中线子程序（线5）
     mov si,4
     mov cx,110		    			;确定点所在列号	
     mov dx,180		    			;确定点所在行号
     mov bx,30						;设置对角线长度
call mid_line				        ;调用画中线子程序（线6）
     mov cx,160
     mov dx,80
     mov bx,30
call mid_line				        ;调用画中线子程序（线7）
	mov di,0			
	mov al,1                          
	mov cx,70			 		    ;重复进行行、列、对角的设置
	mov dx,20
	mov bx,160
	call box			 			;调用画方框子程序
	mov di,0			
	mov al,1                           
	mov cx,130		     			;进行列的设置
	mov dx,80						;进行行的设置
	mov bx,40						;进行对角线的设置
call box			 			    ;再次绘制下一个方块，比上一个大
	mov di,0
	mov cx,95			 			;进行列的设置
	mov dx,45						;进行行的设置
	mov al,1
	mov bx,110						;进行对角线的设置
call box						    ;再次绘制下一个方块，比上一个略小
	mov cx,115		    			;进行列的设置
	mov dx,65						;进行行的设置
	mov al,1
	mov bx,70						;进行对角线的设置
call box						    ;调用画方框子程序
	mov di,1                          
	call fill						;填充步骤1，调用fill函数
	call fill_2						;填充步骤2，调用fill_2函数
	call fill_3						;填充步骤3，调用fill_3函数
	mov cx,149                      	  
	mov dx,120					
	mov al,2
	mov bx,60
	mov si,0
call draw_line					    ;画线子程序调用
	mov cx,151						;列
	mov dx,120						;行
	mov al,2
	mov bx,60						;对角线
	mov si,0
call draw_line
heart_:             			    ;开始绘制心型图案
	call cls_box					;清除最小方框内的内容/清除心
	call heart						;调用画心子程序
	mov ah,08						;从键盘输入一个字符，但不送显示器显
	int 21h
	cmp al,'q'						;(al)=’q’时，执行ok的内容，即退出
	jz ok
	cmp al,20h						;(al)=空格时，转去执行heart_的内容，即清除心并重新画心
	jz heart_						;跳转到heart_子程序
	call clear						;清除最小方框内的内容/清除心
	jmp sss			    			;清屏后转去执行sss的内容，即动画重复
	ok:				    			;退出分支程序
	ret								;返回主程序
	main endp						;主程序结束，填充子程序
	fill proc near            		;填充函数fill
	mov full,0
	mov al,5
	mov cx,160						;确定开始填充的行数列数以及对角线
	mov dx,121						
	mov si,0
	mov bx,60						;对角线的参数传递
	fill_Y:							;填充子函数fill_Y
	push cx			   				;分别进栈以完成填充
	push dx			    			
	push bx			    			
call draw_line					    ;调用画线子程序
	pop bx			    			
	pop dx			    			
	pop cx
	sub bx,2		    			
	inc cx							
	add dx,2			
	inc full
	cmp full,30						;第一次填充完毕
	jne fill_y          			;执行跳转，循环进行fill_Y函数
	ret								;子程序返回
	fill endp						;fill函数结束
	fill_2 proc near    			;填充函数fill_2
	mov full,0
	mov al,5
	mov cx,140						;确定开始填充的行数列数以及对角线
	mov dx,121
	mov si,0
	mov bx,60
	fill_Y1:						;填充子程序fill_Y1
	push cx							;分别进栈以完成填充
	push dx
	push bx
call draw_line       			    ;开始绘制线条
	pop bx
	pop dx               			
	pop cx
	sub bx,2
	dec cx
	add dx,2
	inc full
	cmp full,30						;第二次填充完毕
	jne fill_y1						;执行跳转，循环进行fill_Y1函数
	ret								;子程序返回
	fill_2 endp          			;结束填充函数fill_2
	fill_3 proc near     			;第三个填充中间部分线条程序
	mov al,1             
	mov full,0           
	mov si,0             			;确定开始填充的行数列数以及对角线
	mov cx,140
	mov dx,121
	mov bx,60
	re_fill:             			;重复执行填充函数re_fill
	push bx
	push cx
	push dx
call draw_line       			    ;调用画线程序用线填充
	pop dx
	pop cx
	pop bx
	inc cx
	inc full             			
	cmp full,9           			;第三次填充完毕
	jne re_fill						;执行跳转，循环进行fill_Y1函数
	mov full,0
	mov cx,159
	mov dx,121
	mov bx,60
	re_fill2:						;重复执行填充函数re_fill2，与re_fill函数基本相同			
	push bx
	push cx
	push dx
call draw_line					    ;调用画线程序用线填充
	pop dx
	pop cx
	pop bx
	dec cx
	inc full
	cmp full,9						;填充完毕
	jne re_fill2					;执行跳转，循环进行re_fill2函数
	ret								;子程序返回
	fill_3 endp						;fill_3子程序结束
			
	draw_Line proc near  			;绘制线条的子程序            
	push bx
	cmp si,0
	jz V_line1						;si=0时，去执行V_line1函数
	add bx,cx 
H_line:							    ;提示信息函数H_line
	mov ah,0ch           			;显示提示信息，即buff1的字符串内容
	int 10h
	cmp di,0             			;比较指令做比较如果为0    
	jz aa0               			;执行跳转到aa0
	cmp di,1						;为1则跳转到aa1
	jz aa1							;执行跳转到aa1
	call delay           			;调用延时程序
	aa1:							;aa1函数，进行延迟操作
	call delay						;调用延时程序
	aa0:							;aa0函数，进行画线操作
	inc cx               			;cx操作数加1，返回
	cmp cx,bx
	jne H_line						;跳转到H_line函数
	jmp exit_line					;执行结束后跳转exit_line，结束操作
V_line1:						    ;画线程序1
	add bx,dx
V_line:							    ;画线程序2
	mov ah,0ch
	cmp di,0
	jz bb0							;相当于前面的递归，为0跳转到bb0
	cmp di,1
	jz bb1                  		;是1跳转到bb1
	call delay              		;调用延时程序
	bb1:							;bb1函数，进行延迟操作
	call delay						;进行延迟操作
	bb0:

	int 10h                 		;向cpu发送中断指令
	inc dx
	cmp dx,bx
	jne V_line						;跳转回到到V_line，循环函数
	exit_line:              		;退出绘制线条程序

	pop bx
	ret								;返回子程序
	draw_Line endp					;raw_Line 函数结束

	xie_line proc near      		;绘制十字线的子程序
			 
	add bx,cx
	cmp si,1
	jz xieline_1					;判断并跳转到xieline_1
xieline_0:
	mov ah,0ch               		;数据传送
	int 10h                  		;向cpu发送中断指令
	inc dx                   		;dx,cx指向下一个地址
	inc cx
	cmp cx,bx
	jne xieline_0            		;判断是否条件转移
	jmp exit_xie             		;无条件退出
xieline_1:
	mov ah,0ch
	int 10h
	dec dx
	inc cx
	cmp cx,bx
	jne xieline_1
	exit_xie:						;调用结束画线子程序
	ret								;返回子程序
	xie_line endp					;xie_line子程序结束
Mid_line proc near  			    ;开始绘制十字线子程序             
	add bx,cx
	cmp si,2						;比较si=2时，转去执行midline_2的内容
	jz midline_2
	cmp si,3						;比较si=3时，转去执行midline_2的内容
	jz midline_3
	cmp si,4						;比较si=4时，转去执行midline_2的内容
	jz midline_4
midline_1: 						    ;画角度大于90°，且斜率较小的斜线
	mov ah,0ch						;BOIS调用10H中断类型12号功能写点及着色
	int 10h
	inc dx			    			;每次行坐标加1
	add cx,2						;每次列坐标加2
	cmp cx,bx						;比较cx与bx，相当于确定斜线的长度
	jne midline_1					;cx≠bx时继续画斜线
	jmp exit_lines
midline_2:						    ;画角度大于90°，且斜率较大的斜线
	mov ah,0ch
	int 10h
	add dx,2						;每次行坐标加2
	inc cx			    			;每次列坐标加1
	cmp cx,bx
	jne midline_2
	jmp exit_lines					;画完退出该子程序
midline_3:						    ;画角度小于90°，且斜率较小的斜线
	mov ah,0ch
	int 10h
	dec dx			    			;每次行坐标减1
	add cx,2						;每次列坐标加2
	cmp cx,bx
	jne midline_3
	jmp exit_lines
midline_4:						    ;画角度小于90°，且斜率较小的斜线
	mov ah,0ch
	int 10h
	sub dx,2						;每次行坐标减2
	inc cx			    			;每次列坐标加1
	cmp cx,bx
	jne midline_4
	exit_lines:						;退出画斜线子程序
	ret				    			;返回主程序，结束中断
	mid_line endp					;画斜线子程序结束
box proc near        			    ;绘制方块
	push cx
	push dx
	push cx							
	push dx							
	push cx			
	push dx
	push cx
	push dx
	mov si,1
call draw_line         			    ;图形上方
	pop dx
	pop cx
	add cx,bx
	mov si,0
call draw_line         			    ;图形右边
	pop dx
	pop cx
	mov si,0
call draw_line         			    ;图形左边               
	pop dx
	pop cx
	mov si,1
	add dx,bx

call draw_line         			    ;图形底部
				 
	pop dx
	pop cx
	ret								;返回子程序
	box endp						;box子程序结束
	space proc near        			;显示空间			
	mov ah,02
	mov dl,' '
	int 21h
	ret								;返回子程序
	space endp						;space子程序结束
	return proc near       			;回车执行程序		 
	mov ah,2
	mov dl,0ah
	int 21h
	mov dl,0dh
	int 21h
	ret
	return endp
text proc near         			    ;显示文本信息		 
	mov bh,0
	mov dh,0
	mov dl,0
	mov ah,2
	int 10h
	mov dx,offset buff2	    		;将文本信息打印出来
	mov ah,09
	int 21h
	text endp
heart proc near	         		    ;绘制心
	mov cx,136                        
	mov dx,93
	mov si,0
	mov bx,5
	mov al,2
call draw_line					    ;调用画线子程序，绘制第一个心
	mov cx,137               		                
	mov dx,91
	mov si,0
	mov bx,9
call draw_line	         		    ;调用画线子程序，绘制第二个心
	mov cx,138                        
	mov dx,90
	mov si,0
	mov bx,12
call draw_line					    ;重复调用画线子程序，依次递增的画线
	mov cx,139          			;确定点所在列号绘制第一个方块的上横线            
	mov dx,89						;确定点所在行号
	mov si,0
	mov bx,14
call draw_line					    ;调用画线子程序绘制第二条线
	mov cx,140          			;给出画线点所在列号绘制右边竖线              
	mov dx,88						;给出画线点所在行号
	mov si,0
	mov bx,16
call draw_line					    ;调用画线子程序绘制第三条线
	mov cx,141          			;确定点所在列号绘制左边竖线              
	mov dx,88						;确定点所在行号
	mov si,0
	mov bx,17
call draw_line					    ;调用画线子程序绘制第四条线
	mov cx,142         	 			;确定点所在列号绘制下横线             
	mov dx,87						;确定点所在行号
	mov si,0
	mov bx,19						
								    ;以下方块为逐渐缩进的几个
call draw_line					    ;调用画线子程序画第二个方块
	mov cx,143          			;确定点所在列号画出横线               
	mov dx,87						;确定点所在行号
	mov si,0
	mov bx,20
call draw_line					    ;调用画线子程序绘制第二条线
	mov cx,144          			;确定点所在列号绘出左竖线               
	mov dx,87						;确定点所在行号
	mov si,0
	mov bx,21
call draw_line					    ;调用画线子程序绘制第三条线
	mov cx,145          			;确定点所在列号绘制右竖线                    
	mov dx,88						;确定点所在列号     
	mov si,0
	mov bx,21
call draw_line					    ;调用画线子程序绘制第四条线
	mov cx,146          			;确定点所在列号画横线               
	mov dx,88						;确定点所在列号  
	mov si,0
	mov bx,22
call draw_line					    ;开始绘制逐渐缩小正方形第一条线 
	mov cx,147         				;确定点所在列号画横线           
	mov dx,89						;确定点所在列号
	mov si,0
	mov bx,22
call draw_line					    ;绘制第二条线右竖线
	mov cx,148          			;确定点所在列号              
	mov dx,90						;确定点所在列号	
	mov si,0
	mov bx,22
call draw_line      			    ;绘制第三条线左竖线
	mov cx,149          			;从所在列画左边竖线             
	mov dx,91           			;确定所在行
	mov si,0            
	mov bx,22
call draw_line      			    ;第四条线 下横线画完第二个直接缩进显示的小方块
	mov cx,150                    
	mov dx,91           			;确定所在列号和行号绘制   
	mov si,0
	mov bx,22
call draw_line      			    ;进行缩进展示的最后一个小方块展示
	mov cx,151          			;确定行数列数后开始绘制             
	mov dx,90           			;绘制的位上方横线
	mov si,0
	mov bx,22
call draw_line      			    ;左边竖线
	mov cx,152                        
	mov dx,89           			;确定行数列数绘制
	mov si,0
	mov bx,22
call draw_line      			    ;右边竖线
	mov cx,153                       
	mov dx,88
	mov si,0            			;确定行数列数绘制
	mov bx,22
call draw_line      			    ;下方竖线
	mov cx,154          			;确定行数列数绘制              
	mov dx,88           			;缩进小正方形绘制完
	mov si,0
	mov bx,21
call draw_line      			    ;重绘最小包围心得方块
	mov cx,155          			;确定行数列数绘制上方横线              
	mov dx,87
	mov si,0
	mov bx,21
call draw_line      			    ;左边竖线
	mov cx,156          			;确定行数              
	mov dx,87
	mov si,0            			;确定列数
	mov bx,20
call draw_line      			    ;右边竖线
	mov cx,157                       
	mov dx,87          				;确定行数列数绘制
	mov si,0
	mov bx,19
call draw_line      			    ;最后一条上方横线，完成绘制
	mov cx,158          			;确定行数列数              
	mov dx,88
	mov si,0
	mov bx,17
call draw_line      			    ;绘制交叉的斜线
	mov cx,159                      ;找行坐标 
	mov dx,88						;找列坐标，然后进行绘制
	mov si,0
	mov bx,16
call draw_line      			    ;绘制十字线
	mov cx,160                      ;找行坐标  
	mov dx,89						;找列坐标，然后进行绘制
	mov si,0
	mov bx,14
call draw_line      			    ;绘制第三组交叉的斜线
	mov cx,161                       
	mov dx,90
	mov si,0
	mov bx,12
call draw_line      			    ;绘制第四组交叉的斜线
	mov cx,162                        
	mov dx,91
	mov si,0
	mov bx,9
call draw_line      			    ;最后一组交叉的斜线
	mov cx,163                        
	mov dx,93
	mov si,0
	mov bx,5
call draw_line
ret                 			    ;子程序返回
heart endp                  	    ;绘制心型动画程序结束
delay proc near 				    ;延时子程序
	push cx 				    	;进栈操作对数据进行保护
	push dx 				    	
	mov dx,25 ; 
	dl2: mov cx,2801 						 
	dl3: loop dl3 			    	
	dec dx 				        	 
	jnz dl2 				    	 
	pop dx 
    pop cx 			    	
	ret 					    	;返回主程序 
	delay endp 			        	;延时程序结束 
clear proc near 				    ;清屏子程序 
	mov al,0 						;屏幕初始化
	mov bx,0 						
	mov cx,0 						;并将光标回到起始点
	mov dx,0 
	line: 
	mov ah,0ch 			        
	int 10h 				    	;在指定的位置显 示一个点 
	inc cx 
	cmp cx,320                  	;像素设置 320*200  
	mov cx,0 
	inc dx;
	cmp dx,200 
	jne line 
	ret 							;返回主程序
	clear endp 
cls_box proc near 		    	    ;清除最小 方框内的内容，即清除心 
	mov al,0 						;光标位置回到起始点
	mov bx,0 
	mov cx,131 
	mov dx,81 
	s_line: 
	mov ah,0ch 
	int 10h 					 	;在指定的位置显示一个点 
	inc cx 				    	 	;点位置的横坐标自加 jne	
	jne s_line
	cmp cx,17						
	mov cx,131 
	inc dx 
	cmp dx,120 
	jne s_line 
	ret 							;返回子程序
	cls_box endp 					;清除程序结束
code ends 						    ;结束模块
end start						    ;主程序退出