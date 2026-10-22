; Exercise: 25-comment-trace
;
; Exit 9. Every instruction needs an end-of-line comment.
; Expected exit: 9
;
.code
ex_25_comment_trace PROC
    sub rsp, 40 ; allocate shadow space for call
    mov rcx, 9          ; set exit code parameter
    mov     eax, 9
    add     rsp, 40
    ret
ex_25_comment_trace ENDP
main PROC
    sub     rsp, 40
    call    ex_25_comment_trace
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
