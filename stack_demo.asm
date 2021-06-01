;
; A simple boot sector that demonstrates the stack.
;

; We want interrupt 10, sub code ah.
; (int 10, ah = 0eh) = scrolling teletype BIOS routine

; Set the high order byte for register ax as part of the 
; routine for scrolling teletype. We will actually call the
; interrupt later.
mov ah, 0x0e

; Set the base of the stack a little above where BIOS loads the
; boot sector so that BIOS won't overwrite the stack.
; bp = stack base = bottom of stack
; sp = stack top
mov bp, 0x8000
mov sp, bp

; Push some characters on the stack for later retreival. These
; are pushed on as 16-bit (word sized) values, so the most
; significant byte will be added by our assembly as 0x00.
; Single quotes tell it to interpret as ASCII.
push 'A'
push 'B'
push 'C'

;We can only pop 16-bits, so pop to bx then copy bl (the lower
; 8 bits, the char) to al.
pop bx
mov al, bl

; Call interrupt 10 (we previously set register 'ah' to define
; which routine we want - teletype.
; This prints 'C'
int 0x10    

; To prove that our stack grows downwards from bp, copy the
; char at 0x8000 - 0x10 (16 bits) into al, then print.
; This prints 'C' again
mov al, [0x7ff0]
int 0x10

; Jump to the current address (infinitely).
; (keep the program running)
jmp $

; Padding and magic BIOS number for boot sector.
times 510-($-$$) db 0
dw 0xaa55

