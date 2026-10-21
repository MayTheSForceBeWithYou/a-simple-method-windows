; 05-sar-sign.asm
;
; Use SAR (shift arithmetic right) to divide a signed negative number.
;
; Task: Load -16 into RAX, then use SAR to divide by 4 (shift right by 2).
;       Exit with the result (should be -4, which is 252 as an 8-bit unsigned).
;
; Hint: SAR preserves the sign bit, correctly dividing signed values.
;       Use SAR, not SHR, for signed division.

.CODE

EXTRN ExitProcess:PROC

main PROC
    mov     rax, -16        ; Signed negative value
    
    ; TODO: Shift arithmetic right by 2 to divide by 4
    
    mov     ecx, eax
    and     ecx, 0FFh       ; Exit with low byte
    call    ExitProcess     ; Should exit with 252

    ; TODO: complete exercise (scaffold uses wrong exit code)
    mov ecx, 1
    call ExitProcess
main ENDP

END
