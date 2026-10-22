; Exercise: 24-from-scratch-sim-integrate
;
; FROM SCRATCH: one tick: place path, peep step, cash+=1; exit cash 1.
; Expected stdout: (none)
;
; Contract: implement `ex_24_from_scratch_sim_integrate` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 1
;
.CODE
EXTRN ExitProcess:PROC
EXTERNDEF ex_24_from_scratch_sim_integrate:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_24_from_scratch_sim_integrate in this file.
    call    ex_24_from_scratch_sim_integrate
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
