; 07-poll-stub: poll stub
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_07_poll_stub:PROC
main PROC
    ; TODO: implement ex_07_poll_stub (student routine; defined in solutions/).
    call    ex_07_poll_stub
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
