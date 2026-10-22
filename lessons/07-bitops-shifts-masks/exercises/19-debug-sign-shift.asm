; 19-debug-sign-shift.asm
;
; Debug a sign-extension bug when shifting.
; Use MOVSX and SAR. Exit with low byte of result (255 for -1 >> 1).
;
; Expected exit: 255

.CODE

EXTRN ExitProcess:PROC
EXTRN ex_19_debug_sign_shift:PROC

sign_shift_bug PROC
    mov al, 0FFh
    movzx rax, al            ; BUG: zero-extend; should be MOVSX
    shr rax, 1               ; BUG: unsigned shift; should be SAR after sign extend
    ret
sign_shift_bug ENDP

main PROC
    sub     rsp, 40
    ; TODO: write ex_19_debug_sign_shift in this file.
    call    ex_19_debug_sign_shift
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
