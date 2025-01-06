org 0x0100

jmp start

num: db 1,2,3,4,5,6,7,8,9,10   
even: db 0,0,0,0,0             
odd: db 0,0,0,0,0             

start:
    mov bx, 0        ; bx will be used for 'num' array
    mov di, 0        ; di will be used for 'even' array
    mov si, 0        ; si will be used for 'odd' array
    mov cl, 2        ; cl is the divisor (2)

condition:
    mov al, [num+bx] 
    xor ah, ah       ; Clear AH for remainder
    div cl           ; al = al / cl, remainder in AH
    test ah, ah      ; Check if remainder is zero (even)
    jz Even          ; If remainder is 0, jump to 'ev' (even)
    
  ;Otherwise it's odd
    mov al, [num+bx] 
    mov [odd+si], al    ; Store the odd number
    add si, 1           ; Increment odd index
    jmp move         

Even:
    mov al, [num+bx]
    mov [even+di], al   ; Store the even number
    add di, 1           ; Increment even index
   

move:
    add bx, 1         
    cmp bx, 10        
    jne condition    

done:
    mov ax, 0x4c00   
    int 0x21
