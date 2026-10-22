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
EXTRN ex_04_shl_mul:PROC

main PROC
    sub     rsp, 40
    ; TODO: implement ex_04_shl_mul (student routine; defined in solutions/).
    call    ex_04_shl_mul
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
