;
; A simple boot sector that calls a function.
;

; Tell the assembler where the code will be loaded
mov al, 'Y'
call print_char

; Jump to the current address (infinitely).
jmp $

; This will simply be replaced by the contents of the file.
%include "print_char.asm"

; Padding and magic BIOS number for boot sector.
times 510-($-$$) db 0
dw 0xaa55
