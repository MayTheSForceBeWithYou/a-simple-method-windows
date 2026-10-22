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
