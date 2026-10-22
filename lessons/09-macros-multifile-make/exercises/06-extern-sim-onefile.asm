; Exercise: 06-extern-sim-onefile
;
; Simulate two units in one file with helper procedure; exit 5.
;
; Contract: implement `ex_06_extern_sim_onefile` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 5
;
.CODE

EXTRN ExitProcess:PROC
EXTRN ex_06_extern_sim_onefile:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_06_extern_sim_onefile in this file.
    call    ex_06_extern_sim_onefile
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
