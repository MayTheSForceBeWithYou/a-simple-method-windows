; Exercise: 07-poll-stub
;
; No event -> exit 0.
; Expected stdout: (none)
; Expected exit: 0
;
.code
ex_07_poll_stub PROC
    sub rsp, 40
    xor rcx, rcx
    mov     eax, ecx
    add     rsp, 40
    ret
ex_07_poll_stub ENDP
main PROC
    sub     rsp, 40
    call    ex_07_poll_stub
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
