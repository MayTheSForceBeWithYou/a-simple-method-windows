; Exercise 19: debug q shift
;
; BUG: forgot >>16 after Q mul. Fix 2*3 Q mul -> 6.
; Expected exit: 6

EXTERN ExitProcess:PROC

.code
ex_19_debug_q_shift PROC
    sub rsp, 40
    mov eax, 2
    shl eax, 16
    mov ebx, 3
    shl ebx, 16
    movsxd rax, eax
    movsxd rbx, ebx
    imul rax, rbx
    shr rax, 16
    shr rax, 16
        mov     eax, ecx
    add     rsp, 40
    ret
ex_19_debug_q_shift ENDP
main PROC
    sub     rsp, 40
    call    ex_19_debug_q_shift
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
