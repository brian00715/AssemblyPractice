;�� ���ڴ�����һ�����ݿ飬���׵�ַΪbuffer (3000H:0200H)��
;���д��16λ�ķ�����20������Ҫ�ҳ����е����ֵ��
;���������MAX�ֵ�Ԫ(��ƫ�Ƶ�ַΪ0228H)��

DATAS SEGMENT
	org 0200h
    buffer dw  0, 1, -5, 10, 256, -128, -100, 45, 6
           dw  3, -15, -67, 39, 4, 20, -1668,-32766
           dw  32765, -525, 300
    count  dw  20
    max    dw  ?
DATAS ENDS

STACKS SEGMENT stack 'stack'
    dw 20 dup(0)  ;��20�ֵĸ���ſռ�
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
    JLE next         ;[si]mem����С�ڵ���AX��ת�Ƶ�next
    mov ax,[si]      ;���mem��ֵ����ax�����滻
    
next:
    loop chk         ;С�������һ����loop�Դ���1
    
    mov max,ax   ;������������max�ֵ�Ԫ
    
    int 20h
    
CODES ENDS
    END START



