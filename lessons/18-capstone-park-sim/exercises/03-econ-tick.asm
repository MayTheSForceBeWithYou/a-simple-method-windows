; Exercise: 03-econ-tick
;
; cash+=5; exit cash 5.
; Expected stdout: (none)
;
; Contract: implement `ex_03_econ_tick` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 5
;
.CODE
EXTRN ExitProcess:PROC
EXTERNDEF ex_03_econ_tick:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_03_econ_tick in this file.
    call    ex_03_econ_tick
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
