;
; a simple boot sector program that demonstrates addressing.
;

; int 10/ah = 0eh -> interrupt to the address for the scrolling teletype BIOS routine
mov ah, 0x0e

; First attempt
mov al, the_secret
int 0x10            ; Does this print an X?

; Second attempt
mov al, [the_secret]
int 0x10            ; Does this print an X?

; Third attempt
mov bx, the_secret
add bx, 0x7c00
mov al, [bx]
int 0x10            ; Does this print an X?

; Fourth attempt
mov al, [0x7c1e]
int 0x10            ; Does this print an X?

; Jump forever
jmp $

the_secret:
db "X"

; Padding and magic BIOS Number.
times 510-($-$$) db 0
dw 0xaa55

