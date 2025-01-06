[org 0x0100]

jmp start

clear:
mov ax,0xb800
mov es,ax
mov di,0
l:
mov word[es:di],0x0720
add di,2
cmp di,4000
jle l

ret

paramid:
push bp
mov bp,sp

mov ax, 0xb800
mov es, ax
mov di,160
mov cx, 1
mov ax, 0
mov ah, 9
l1:
mov si, cx
mov bx,0

l2:
mov word[es:di], 0x0720
add di, 2
add bx,2
inc si
cmp si, [bp+4]
jle l2


mov dx, 1
l3:
mov ax, dx
add ax,0x30
mov ah, 9

mov word[es:di], ax
add di, 2

inc dx
add bx,2
cmp dx, cx
jle l3

mov dx, 0
mov dx, cx
dec dx 
l4:
cmp dx, 1
jl end

mov ax, dx
add ax, 0x30
mov ah,9
mov word[es:di],ax
add bx,2
add di,2
dec dx
cmp dx, 1
jge l4

end:
mov ax,160
sub ax,bx
add di,ax

inc cx
cmp cx, [bp+4]
jle l1

ret 2
start:

call clear
mov ax, 5
push ax
call paramid

mov ax,0x4c00
int 0x21