[org 0x0100]

jmp start

multiplicand: dd 1300
multiplier: dw 500
result: dd 0

start:


mov dx, [multiplier]
mov cl, 16

check:

shr dx, 1
jnc skip

mov ax, [multiplicand]
add [result],ax
mov ax, [multiplicand+2]
adc [result+2], ax	
mov ax, [multiplicand+4]
adc [result+4], ax	
mov ax, [multiplicand+6]
adc [result+6], ax	

skip:
shl word[multiplicand], 1
rcl word [multiplicand+2], 1
rcl word [multiplicand+4], 1
rcl word [multiplicand+6], 1
dec cl
jnz check


mov ax, 0x4c00
int 0x21