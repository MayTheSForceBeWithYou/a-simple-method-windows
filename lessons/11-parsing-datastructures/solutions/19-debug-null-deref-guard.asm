; Exercise 19: debug null guard
;
; BUG: walks next without null check. Fix empty list sum=0.
; Expected exit: 0

EXTERN ExitProcess:PROC

.code
ex_19_debug_null_deref_guard PROC
    sub rsp, 40
    xor rsi, rsi
    xor rcx, rcx
loop_walk:
    test rsi, rsi
    jz done_walk
    add rcx, QWORD PTR [rsi]
    mov rsi, QWORD PTR [rsi+8]
    jmp loop_walk
done_walk:
    mov     eax, 0
    add     rsp, 40
    ret
ex_19_debug_null_deref_guard ENDP
main PROC
    sub     rsp, 40
    call    ex_19_debug_null_deref_guard
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
