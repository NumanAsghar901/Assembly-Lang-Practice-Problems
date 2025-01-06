[org 0x0100]

start:
mov bx,0

comparison:
mov ax, [data+bx]
cmp ax, [data+bx+2]
jb noswapping

;swaping
mov dx,[data+bx+2]
mov [data+bx+2],ax
mov [data+bx],dx 
mov byte[swap], 1
noswapping:
add bx,2
cmp bx,8
jmp comparison

cmp byte[swap],0
jnz start

mov ax, 0x4c00
int 0x21

data: dw 2,4,9,10,8
swap: db 0