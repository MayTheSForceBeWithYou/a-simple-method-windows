; Exercise: 23-collatz-steps
;
; Collatz steps for n=6 until 1: 6->3->10->5->16->8->4->2->1 = 8 steps. Exit 8.
;
; Contract: implement `ex_23_collatz_steps` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 8
;
.CODE

EXTRN ExitProcess:PROC
EXTERNDEF ex_23_collatz_steps:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_23_collatz_steps in this file.
    call    ex_23_collatz_steps
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
