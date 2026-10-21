; 24-from-scratch-ntz.asm (from scratch)
;
; Count trailing zeros (number of zeros at the right before first 1 bit).
;
; Task: Count trailing zeros in 0b10101000 (168).
;       There are 3 trailing zeros. Exit with the count.
;
; Hint: Loop: test bit 0. If 0, increment counter and shift right.
;       If 1, stop. Return counter.

.CODE

EXTRN ExitProcess:PROC

main PROC FRAME
    push    rbx
    .pushreg rbx
    .endprolog
    
    mov     rbx, 168        ; 0b10101000 (3 trailing zeros)
    xor     rax, rax        ; Counter
    
    ; TODO: Implement trailing zero count loop
    
    mov     ecx, eax
    call    ExitProcess     ; Should exit with 3

    ; TODO: complete exercise (scaffold uses wrong exit code)
    mov ecx, 1
    call ExitProcess
main ENDP

END
