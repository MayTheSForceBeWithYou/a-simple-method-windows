; 14-multifile-sim-globals.asm
; Single-file simulation of PUBLIC, return 42.

.CODE

EXTRN ExitProcess:PROC
EXTRN ex_14_multifile_sim_globals:PROC

main PROC
    sub     rsp, 40
    ; TODO: implement ex_14_multifile_sim_globals (student routine; defined in solutions/).
    call    ex_14_multifile_sim_globals
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
