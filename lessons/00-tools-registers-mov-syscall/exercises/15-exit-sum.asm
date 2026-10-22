; Exercise: 15-exit-sum
;
; Set r8=10, r9=20, r10=12. Sum into rcx; exit (42).
;
; Contract: implement `ex_15_exit_sum` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 42
;
.CODE

EXTRN ExitProcess:PROC
EXTRN ex_15_exit_sum:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_15_exit_sum in this file.
    call    ex_15_exit_sum
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
