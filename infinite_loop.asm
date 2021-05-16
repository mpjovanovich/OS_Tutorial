;
; A simple boot sector program that loops forever.
;

; Devine a label, "loop", that will allow us to jump
; back to it forever.
loop:

    ; Use a simple CPU instruction that jumps to a 
    ; new memory address to continue execution. In
    ; our case, jump to the address of the current
    ; instruction.
    jmp loop

; Our program must fit into 512 bytes with the 
; last two bytes being the magic number. Here
; tell the assembly compiler to pad out the
; program with enough zero bytes to bring it to
; the 510th byte.
times 510-($-$$) db 0

; Last two bytes (one 16 bit word) form the magic number
; so BIOS knows this is a boot sector.
dw 0xaa55

