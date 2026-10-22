; Exercise: 15-econ-ticket
;
; Exercise 15: econ ticket
; cash += ticket 15; from 0 exit 15.
; Expected stdout: (none)
;
; Contract: implement `ex_15_econ_ticket` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 15
;

; 15-econ-ticket: econ ticket
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_15_econ_ticket:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_15_econ_ticket in this file.
    call    ex_15_econ_ticket
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
