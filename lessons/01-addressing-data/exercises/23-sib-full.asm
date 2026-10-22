; Exercise: 23-sib-full
;
; base=addr of table, index=2, scale=8, disp=0. table QWORD 0,0,42,0. Load into rcx.
;
; Contract: implement `ex_23_sib_full` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 42
;
.CODE

EXTRN ExitProcess:PROC
EXTERNDEF ex_23_sib_full:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_23_sib_full in this file.
    call    ex_23_sib_full
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
