; 04-shl-mul.asm
;
; Use SHL (shift left) to multiply by a power of 2.
;
; Task: Load 7 into RAX, then use SHL to multiply by 8 (2^3).
;       Exit with the result (should be 56).
;
; Hint: Shifting left by N multiplies by 2^N.
;       To multiply by 8, shift left by 3.

.CODE

EXTRN ExitProcess:PROC

main PROC
    mov     rax, 7          ; Starting value
    
    ; TODO: Shift left by 3 to multiply by 8
    
    mov     ecx, eax
    call    ExitProcess     ; Should exit with 56

    ; TODO: complete exercise (scaffold uses wrong exit code)
    mov ecx, 1
    call ExitProcess
main ENDP

END
