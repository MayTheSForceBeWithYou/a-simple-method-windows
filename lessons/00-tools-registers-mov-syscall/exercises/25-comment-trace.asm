; Exercise 25: comment trace
;
; Exit 9. Every instruction needs an end-of-line comment.
;
; Build: ml64 /c 25-comment-trace.asm && link /OUT:25-comment-trace.exe /ENTRY:main /SUBSYSTEM:CONSOLE 25-comment-trace.obj kernel32.lib
;
; Expected exit: 9


.CODE

EXTRN ExitProcess:PROC
EXTRN ex_25_comment_trace:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_25_comment_trace in this file.
    call    ex_25_comment_trace
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
