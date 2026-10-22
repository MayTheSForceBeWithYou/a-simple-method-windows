; Exercise: 17-closure-sim
;
; Context in r12 (nonvolatile). add_ctx(5)=5+10=15.
;
; Contract: implement `ex_17_closure_sim` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 15
;
.CODE

EXTRN ExitProcess:PROC
EXTERNDEF ex_17_closure_sim:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_17_closure_sim in this file.
    call    ex_17_closure_sim
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
