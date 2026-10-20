; 01-and-mask.asm
;
; Use AND to extract the low nibble (low 4 bits) from a value.
;
; Task: Load 0xAB into AL, then use AND with an appropriate mask
;       to keep only bits 0-3 (the low nibble).
;       Exit with the result (should be 0x0B = 11).
;
; Hint: To keep bits 0-3, AND with a mask that has 1s in positions 0-3
;       and 0s everywhere else. What hexadecimal value is 0b00001111?

.CODE

EXTRN ExitProcess:PROC

main PROC
    mov     al, 0ABh        ; Given value
    
    ; TODO: Use AND to extract low nibble (bits 0-3)
    .ERR <TODO: Insert AND instruction with appropriate mask>
    
    movzx   ecx, al
    call    ExitProcess     ; Should exit with 11
main ENDP

END
