;This program convert a string into integer

[org 0x100]
jmp start
strr: db '1234',0
converted: dw 0
pre: dw 0

strlen:
push bp
mov bp,sp
push cx
push di
push si

push ds
pop es
mov di,[bp+4]
mov cx,0xFFFF
mov al,0
repne scasb
mov ax,0xFFFF
sub ax,cx
pop si
pop di
pop cx
pop bp
ret 2

convert:
    mov si, strr           ; Load the address of the input string
    push si
    call strlen            ; Get the string length
    mov cx, ax             ; Store length in cx
    mov bx, 10             ; Base 10 for conversion
    xor ax, ax             ; Clear ax (result accumulator)
l1:
    lodsb                   ; Load next character into al
    sub al, '0'            ; Convert ASCII to numerical value
    mul bx                 ; Multiply current result by 10
    add ax, dx             ; Add the new digit to the result
loop l1
    mov [converted], ax    ; Store the final result in 'converted'
    ret

print_num:
    mov bx, 10             ; Divisor for decimal conversion
    mov di, 0              ; Index for storing digits
    mov ax, [converted]    ; Load the number to be printed
    xor cx, cx             ; Clear digit counter

    ; Convert number to ASCII digits (in reverse order)
ll:
    xor dx, dx             ; Clear dx for division
    div bx                 ; Divide ax by 10, quotient in ax, remainder in dx
    add dl, '0'            ; Convert remainder to ASCII
    push dx                ; Push digit onto stack
    inc cx                 ; Increment digit counter
    cmp ax, 0              ; Check if quotient is 0
    jne ll                 ; Repeat if quotient is not 0

    ; Pop digits from stack and display them
    mov ax, 0xb800         ; Video memory segment
    mov es, ax
    mov di, 0              ; Start at top-left corner of the screen

display_digits:
    pop dx                 ; Get digit from stack
    mov dh, 0x02
    mov [es:di], dx        ; Store ASCII character in video memory
    
    add di, 2              ; Move to next character position
    loop display_digits    ; Repeat for all digits

    ret


start:

mov ah,0
mov al, 0x03
int 10h
call convert
call print_num
mov ax,0x4c00
int 0x21