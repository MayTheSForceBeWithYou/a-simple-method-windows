; Exercise: 16-econ-upkeep
;
; cash -= 3; from 10 exit 7.
; Expected stdout: (none)
;
; Contract: implement `ex_16_econ_upkeep` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 7
;
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_16_econ_upkeep:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_16_econ_upkeep in this file.
    call    ex_16_econ_upkeep
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
