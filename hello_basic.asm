;
; A simple boot sector that prints a message to the screen
; using a BIOS routine.
;

; We want interrupt 10, sub code ah.
; (int 10, ah = 0eh) = scrolling teletype BIOS routine

; Set the high order byte for register ax as part of the 
; routine for scrolling teletype. We will actually call the
; interrupt later.
mov ah, 0x0e

; Set the low order byte to the character to be printed.
mov al, 'H'
; Call interrupt 10 (we previously set register 'ah' to define
; which routine we want - teletype.
int 0x10    

; Repeat...
mov al, 'e'
int 0x10
mov al, 'l'
int 0x10
mov al, 'l'
int 0x10
mov al, 'o'
int 0x10

; Jump to the current address (infinitely).
jmp $

; Padding and magic BIOS number for boot sector.
times 510-($-$$) db 0
dw 0xaa55
