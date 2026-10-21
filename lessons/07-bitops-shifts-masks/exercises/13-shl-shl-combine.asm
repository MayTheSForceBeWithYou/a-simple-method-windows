; 13-shl-shl-combine.asm
;
; Combine two values into one register using shifts.
;
; Task: Put value 0x12 in the high byte (bits 8-15) and 0x34 in the low byte
;       (bits 0-7) of a 16-bit value.
;       Exit with the combined value (should be 0x1234 = 4660).
;
; Hint: Shift the high byte left by 8, OR it with the low byte.

.CODE

EXTRN ExitProcess:PROC

main PROC
    mov     ax, 12h         ; High byte value
    
    ; TODO: Shift left by 8 to position in high byte
    
    ; TODO: OR with low byte value
    
    movzx   ecx, ax
    call    ExitProcess     ; Should exit with 4660 (0x1234)

    ; TODO: complete exercise (scaffold uses wrong exit code)
    mov ecx, 1
    call ExitProcess
main ENDP

END
