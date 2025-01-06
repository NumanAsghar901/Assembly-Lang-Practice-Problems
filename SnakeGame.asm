[org 0x0100]
jmp start

clrscr:     
    push es
    push ax
    push di

    mov ax, 0xb800
    mov es, ax
    mov di, 0

    nextloc:
        mov  word [es:di], 0x0720
        add  di, 2
        cmp  di, 4000
        jne  nextloc

    pop di 
    pop ax
    pop es
    ret
;Make Snake
draw_snake:
    push bp
    mov bp, sp
    push ax
    push bx
    push si
    push cx
    push dx

    mov si, [bp + 6]        ;snake ka address
    mov cx, [bp + 8]        ;length of snake
	dec cx
	
    mov di, 160
    mov ax, 0xB800
    mov es, ax

    mov bx, [bp + 4]		;snake location
    mov ah, 0x02
	mov al, 2
	mov [es:di], ax
	snake_next_part:
        mov al, '-'
		mov [es:di], ax
        mov [bx], di
        inc si
        add bx, 2
        add di, 2
        loop snake_next_part

    pop dx
    pop cx
    pop si
    pop bx
    pop ax
    pop bp
    ret 6
; subroutine for moving snake left
move_snake_left:
    push bp
    mov bp, sp
    push ax
    push bx
    push cx
    push dx
    push es
    push di
    push si
    
    left_movement:
    mov si, [bp + 6]            ;snake 
    mov bx, [bp + 4]            ;snake location
    mov dx, [bx]
    sub dx, 2
    mov di, dx

    mov ax, 0xb800
    mov es, ax
    mov ah, 0x02
    mov al, 2
    mov [es:di],ax             ;snake head placed

    mov cx, [bp + 8]
    mov di, [bx]
    inc si
    mov ah, 0x02
    mov al, '-'
    mov [es:di],ax
    left_location_sort:
        mov ax, [bx]
        mov [bx], dx
        mov dx, ax
        add bx, 2
        
        loop left_location_sort
    mov di, dx
    mov ax, 0x0720
    mov [es:di], ax

    no_left_movement:
		pop si
		pop di
		pop es
		pop dx
		pop cx
		pop bx
		pop ax
		pop bp
		ret 6
;SubRoutine for Up movement
move_snake_up:
    push bp
    mov bp, sp
    push ax
    push bx
    push cx
    push dx
    push es
    push di
    push si
	
    upward_movement:
		mov si, [bp + 6]            ;snake address
		mov bx, [bp + 4]            ;snake location
		mov dx, [bx]
		sub dx, 160
		mov di, dx

		mov ax, 0xb800
		mov es, ax
		mov ah, 0x02
		mov al, 2
		mov [es:di],ax             ;snake head placed

		mov cx, [bp + 8]
		mov di, [bx]
		inc si
		mov ah, 0x02
		mov al, '-'
		mov [es:di],ax
		
		up_location_sort:
			mov ax, [bx]
			mov [bx], dx
			mov dx, ax
			add bx, 2
			
			loop up_location_sort
    mov di, dx
    mov ax, 0x0720
    mov [es:di], ax
    no_up_movement:
		pop si
		pop di
		pop es
		pop dx
		pop cx
		pop bx
		pop ax
		pop bp
		ret 6
;SubRoutine for Down Movement
move_snake_down:
    push bp
    mov bp, sp
    push ax
    push bx
    push cx
    push dx
    push es
    push di
    push si
     
    downward_movement:
		mov si, [bp + 6]            ;snake address
		mov bx, [bp + 4]            ;snake location
		mov dx, [bx]
		add dx, 160
		mov di, dx

		mov ax, 0xB800
		mov es, ax
		mov ah, 0x02
		mov al, 2
		mov [es:di], ax             ;snake head placed

		mov cx, [bp + 8]            ;snake length
		mov di, [bx]
		inc si
		mov ah, 0x02
		mov al, '-'
		mov [es:di],ax
		down_location_sort:
			mov ax, [bx]
			mov [bx], dx
			mov dx, ax
			add bx, 2
			loop down_location_sort
			
    mov di, dx
    mov ax, 0x0720
    mov [es:di], ax

    no_down_movement:
		pop si
		pop di
		pop es
		pop dx
		pop cx
		pop bx
		pop ax
		pop bp
		ret 6
move_snake_right:
    push bp
    mov bp, sp
    push ax
    push bx
    push cx
    push dx
    push es
    push di
    push si

    right_movement:
		mov si, [bp + 6]            ;snake address
		mov bx, [bp + 4]            ;snake location
		mov dx, [bx]
		add dx, 2
		mov di, dx

		mov ax, 0xB800
		mov es, ax
		mov ah, 0x02
		mov al, 2
		mov [es:di], ax             ;snake head placed

		mov cx, [bp + 8]            ;snake length
		mov di, [bx]
		inc si
		mov ah, 0x02
		mov al, '-'
		mov [es:di],ax
		right_location_sort:
			mov ax, [bx]
			mov [bx], dx
			mov dx, ax
			add bx, 2
			
			loop right_location_sort
			
    mov di, dx
    mov ax, 0x0720
    mov [es:di], ax

    no_right_movement:
		pop si
		pop di
		pop es
		pop dx
		pop cx
		pop bx
		pop ax
		pop bp
		ret 6
;Moving Snake
move_snake:
    ; Get keystroke
    push ax
    push bx

    repeat:
		mov ah, 0
		int 0x16
		; AH = BIOS scan code
		cmp ah, 0x48	;UP
		je up
		cmp ah, 0x4B	;LEFT
		je left
		cmp ah, 0x4D	;RIGHT
		je right
		cmp ah, 0x50	;DOWN
		je down
		cmp ah, 1
		jne repeat      ; loop until Esc is pressed
		;Escape check
		mov ax, 0x4c00
		je end_prog
		;UpWard Movement
    up:
        push word [intial_snake_length]
        mov bx, snake
        push bx
        mov bx, snake_locations
        push bx
        call move_snake_up
		jmp move_snake

    down:
        push word [intial_snake_length]
        mov bx, snake
        push bx
        mov bx, snake_locations
        push bx
        call move_snake_down
		jmp move_snake
		
    left:
        push word [intial_snake_length]
        mov bx, snake
        push bx
        mov bx, snake_locations
        push bx
        call move_snake_left
		jmp move_snake
		
    right:
        push word [intial_snake_length]
        mov bx, snake
        push bx
        mov bx, snake_locations
        push bx
        call move_snake_right
		jmp move_snake
		
    exit:
        pop bx
        pop ax
        ret

start:

    call clrscr

    push word [intial_snake_length]
    mov bx, snake
    push bx
    mov bx, snake_locations
    push bx
	
    call draw_snake
    call move_snake
end_prog:
    mov ax, 0x4c00
    int 0x21

intial_snake_length: dw 5
snake: db '','','','',''
snake_locations: dw 0