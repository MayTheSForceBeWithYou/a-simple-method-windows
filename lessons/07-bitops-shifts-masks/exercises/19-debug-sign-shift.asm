; 19-debug-sign-shift.asm
;
; Debug a sign-extension bug when shifting.
;
; Task: Given value -1 (0FFh in AL), extend to 64 bits then shift right by 1.
;       If you use MOVZX (zero-extend), SHR gives 127.
;       If you use MOVSX (sign-extend), SAR gives -1 (255 in low byte).
;
; Use MOVSX and SAR. Exit with low byte of result.
;
; Hint: MOVSX sign-extends; SAR preserves sign. Together they correctly
;       handle signed values across size changes.

.CODE

EXTRN ExitProcess:PROC
EXTRN ex_19_debug_sign_shift:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_19_debug_sign_shift in this file.
    call    ex_19_debug_sign_shift
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
