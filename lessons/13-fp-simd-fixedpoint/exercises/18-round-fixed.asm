; Exercise: 18-round-fixed
;
; Round Q16.16 3.75 to 4.
;
; Contract: implement `ex_18_round_fixed` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 4
;
.CODE
EXTRN ExitProcess:PROC
EXTERNDEF ex_18_round_fixed:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_18_round_fixed in this file.
    call    ex_18_round_fixed
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
