; Exercise: 19-debug-sign-shift
;
; Implement `ex_19_debug_sign_shift` in this file.
;
; Contract: implement `ex_19_debug_sign_shift` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 252
;
.CODE

EXTRN ExitProcess:PROC
EXTERNDEF ex_19_debug_sign_shift:PROC

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
