; 06-extern-sim-onefile.asm
; Single-file simulation of external function, exit 5.
; Task: Define helper function, call it from main, exit with result.

.CODE

EXTRN ExitProcess:PROC
EXTRN ex_06_extern_sim_onefile:PROC

main PROC
    sub     rsp, 40
    ; TODO: implement ex_06_extern_sim_onefile (student routine; defined in solutions/).
    call    ex_06_extern_sim_onefile
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
