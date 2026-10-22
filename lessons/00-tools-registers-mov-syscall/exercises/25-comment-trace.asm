; Exercise: 25-comment-trace
;
; Exit 9. Every instruction needs an end-of-line comment.
;
; Contract: implement `ex_25_comment_trace` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 9
;
.CODE

EXTRN ExitProcess:PROC
EXTERNDEF ex_25_comment_trace:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_25_comment_trace in this file.
    call    ex_25_comment_trace
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
