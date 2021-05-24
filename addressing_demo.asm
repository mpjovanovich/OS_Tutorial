;
; a simple boot sector program that demonstrates addressing.
;

; We are trying to print the character X (ASCII code 0x58). This is located
; at offset 30 bytes from the start of the code, immediately before the zero padding.

; int 10/ah = 0eh -> interrupt to the address for the scrolling teletype BIOS routine
mov ah, 0x0e

; First attempt
; This moves the immediate offset (? whatever that is) into 'al' as the character to print.
; Does this print an X? - no. The offset isn't what we want to print.
mov al, the_secret
int 0x10

; Second attempt
; We use square brackets instruct the CPU store the contents of the address 
; (like the contents of a pointer).
; Does this print an X? - no. The offset starts at the start of memory rather than the
; start address of the loaded code.
mov al, [the_secret]
int 0x10

; Third attempt
; Move the secret to register bx, then add the program start offset (7c00) to bx.
; Move the contents of bx (the previous offset) to the low byte of register ax.
; Does this print an X? It's supposed to according to the text, but doesn't.
mov bx, the_secret
add bx, 0x7c00
mov al, [bx]
int 0x10

; Fourth attempt
; In this code we've pre-calculated the location of X, 30 bytes (0x1e) after the start of the
; code offset. It's a brute-force approach that we'd have to use if we didn't have labels (like
; 'the_secret').
; Does this print an X? Yes.
mov al, [0x7c1e]
int 0x10

; Jump forever
jmp $

the_secret:
    db "X"

; Padding and magic BIOS Number.
times 510-($-$$) db 0
dw 0xaa55

