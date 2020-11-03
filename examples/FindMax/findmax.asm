;例 在内存中有一个数据块，其首地址为buffer (3000H:0200H)，
;其中存放16位的符号数20个。现要找出其中的最大值，
;并将其存入MAX字单元(其偏移地址为0228H)。

DATAS SEGMENT
	org 0200h
    buffer dw  0, 1, -5, 10, 256, -128, -100, 45, 6
           dw  3, -15, -67, 39, 4, 20, -1668,-32766
           dw  32765, -525, 300
    count  dw  20
    max    dw  ?
DATAS ENDS

STACKS SEGMENT stack 'stack'
    dw 20 dup(0)  ;留20字的个存放空间
STACKS ENDS

CODES SEGMENT
    ASSUME CS:CODES,DS:DATAS,SS:STACKS
START:
    MOV AX,datas
    MOV DS,AX
    lea si,buffer
    mov cx,count
    dec cx
    mov ax,[si]
chk:
    add si,2
    cmp [si],ax
    JLE next         ;[si]mem的数小于等于AX则转移到next
    mov ax,[si]      ;如果mem的值大于ax的则替换
    
next:
    loop chk         ;小了则比下一个，loop自带减1
    
    mov max,ax   ;最后将最大的数存进max字单元
    
    int 20h
    
CODES ENDS
    END START



