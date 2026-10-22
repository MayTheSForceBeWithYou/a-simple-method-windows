; Exercise: 07-poll-stub
;
; Exercise 07: poll stub
; No event -> exit 0.
; Expected stdout: (none)
;
; Contract: implement `ex_07_poll_stub` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 0
;

; 07-poll-stub: poll stub
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_07_poll_stub:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_07_poll_stub in this file.
    call    ex_07_poll_stub
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
