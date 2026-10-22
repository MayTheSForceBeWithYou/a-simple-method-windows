; Exercise: 08-from-scratch-tick
;
; FROM SCRATCH: sim_tick counter to 5; exit 5.
; Expected stdout: (none)
;
; Contract: implement `ex_08_from_scratch_tick` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 5
;
.CODE
EXTRN ExitProcess:PROC
EXTERNDEF ex_08_from_scratch_tick:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_08_from_scratch_tick in this file.
    call    ex_08_from_scratch_tick
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
