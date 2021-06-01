;
; This function prints whatever char is stored in register al
;
print_char:
    pusha           ; Push all register values to the stack
    mov ah, 0x0e    ; Load the teletype routine into ah
    int 0x10        ; Call the teletype routine
    popa            ; Restore the original register values
    ret

