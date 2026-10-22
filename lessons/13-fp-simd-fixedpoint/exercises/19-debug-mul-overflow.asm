; 19-debug-mul-overflow.asm: Debug Q16.16 mul overflow handling
; BUG: full 64-bit product used without high-half discard. Fix small Q mul.
; Expected exit: 6

.CODE
EXTRN ExitProcess:PROC
EXTRN ex_19_debug_mul_overflow:PROC

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
