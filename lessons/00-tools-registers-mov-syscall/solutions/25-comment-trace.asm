; Exercise 25: comment trace
;
; Exit 9. Every instruction needs an end-of-line comment.
;
; Build: ml64 /c 25-comment-trace.asm && link /OUT:25-comment-trace.exe /ENTRY:main /SUBSYSTEM:CONSOLE 25-comment-trace.obj kernel32.lib
;
; Expected exit: 9

EXTERN ExitProcess:PROC

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
