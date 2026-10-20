; Exercise 25: comment trace
;
; Exit 9. Every instruction needs an end-of-line comment.
;
; Build: ml64 /c 25-comment-trace.asm && link /OUT:25-comment-trace.exe /ENTRY:main /SUBSYSTEM:CONSOLE 25-comment-trace.obj kernel32.lib
;
; Expected exit: 9

EXTERN ExitProcess:PROC

.code
main PROC
    sub rsp, 32         ; allocate shadow space for call
    mov rcx, 9          ; set exit code parameter
    call ExitProcess    ; exit process with status
main ENDP
END
