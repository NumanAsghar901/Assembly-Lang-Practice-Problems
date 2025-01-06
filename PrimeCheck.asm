[org 0x100]

mov ax,19   ;original numver
mov di,ax ;copying
cmp ax,2
jl flag  ;not prime

cmp ax,2
je flag2 ;prime

mov bx,2 ;divisor
div bx ;ax=ax/bx

cmp dx,0 ;if no reminder then even
je flag ;not prime


mov cx, di      
sub cx, 1        ;now cx has loop break number
l2:
mov ax, di       ;original number
xor dx, dx  
div bx           ;ax=ax/bx

cmp dx, 0        ;if reminder 0 not prime
je flag          ;not prime flag

inc bx           ;i++  (means adding 1 to divisor)

cmp bx, cx       ;compare divisor with loop break
jl l2            
jmp flag2

flag:
mov byte [notPrime],1
jmp end

flag2:
mov byte [prime],1
jmp end

end:
mov ax,0x4c00
int 0x21

prime: db 0
notPrime: db 0