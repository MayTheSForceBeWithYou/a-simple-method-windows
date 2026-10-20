; Exercise 19: debug null guard
;
; BUG: walks next without null check. Fix empty list sum=0.
; Expected exit: 0

EXTERN ExitProcess:PROC

.code
main PROC
    sub rsp, 32
    xor rsi, rsi
    xor rcx, rcx
loop_walk:
    test rsi, rsi
    jz done_walk
    add rcx, QWORD PTR [rsi]
    mov rsi, QWORD PTR [rsi+8]
    jmp loop_walk
done_walk:
    call ExitProcess
main ENDP
END
