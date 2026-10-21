; 10-bit-set-clear.asm
;
; Set and clear specific bits using OR and AND.
;
; Task: Start with RAX = 0xFF (all low 8 bits set).
;       Clear bit 2 (turn it off).
;       Exit with the result (should be 0xFB = 251).
;
; Hint: To clear bit N, AND with ~(1 << N).
;       In MASM, you can compute the mask: NOT 4 = NOT (1 << 2).
;       Or directly: AND with 0xFB (which is 0xFF with bit 2 cleared).

.CODE

EXTRN ExitProcess:PROC

main PROC
    mov     rax, 0FFh       ; All bits set
    
    ; TODO: Clear bit 2 using AND with inverted mask
    
    mov     ecx, eax
    and     ecx, 0FFh
    call    ExitProcess     ; Should exit with 251

    ; TODO: complete exercise (scaffold uses wrong exit code)
    mov ecx, 1
    call ExitProcess
main ENDP

END
