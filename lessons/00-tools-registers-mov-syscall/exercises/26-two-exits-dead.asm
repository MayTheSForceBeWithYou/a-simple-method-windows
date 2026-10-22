; Exercise: 26-two-exits-dead
;
; Write "alive\n", exit 0, then dead exit 99 after (unreachable).
;
; Contract: implement `ex_26_two_exits_dead` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 0
;
.CODE

EXTRN ExitProcess:PROC
EXTRN ex_26_two_exits_dead:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_26_two_exits_dead in this file.
    call    ex_26_two_exits_dead
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
