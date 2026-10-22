; Exercise: 07-rep-movsb
;
; Copy 5 bytes [1..5]; sum=15.
;
; Contract: implement `ex_07_rep_movsb` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 15
;
.CODE
EXTRN ExitProcess:PROC
EXTERNDEF ex_07_rep_movsb:PROC



main PROC
    sub     rsp, 40

    ; TODO: write ex_07_rep_movsb in this file.
    call    ex_07_rep_movsb
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
