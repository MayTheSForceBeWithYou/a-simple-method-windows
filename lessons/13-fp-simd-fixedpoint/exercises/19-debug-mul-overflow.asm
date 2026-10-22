; Exercise: 19-debug-mul-overflow
;
; Q16.16 multiply 2.0 * 3.0; exit 6.
;
; Contract: implement `ex_19_debug_mul_overflow` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 6
;
.CODE
EXTRN ExitProcess:PROC
EXTERNDEF ex_19_debug_mul_overflow:PROC

q_mul_wide_bug PROC
    mov eax, 2
    shl eax, 16
    mov ebx, 3
    shl ebx, 16
    imul eax, ebx               ; BUG: 32-bit imul loses high half handling
    ret
q_mul_wide_bug ENDP

main PROC
    sub     rsp, 40
    ; TODO: write ex_19_debug_mul_overflow in this file.
    call    ex_19_debug_mul_overflow
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
