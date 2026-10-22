; Exercise: 14-multifile-sim-globals
;
; Simulate module: PUBLIC helper_add; call with 20,22 exit 42.
;
; Contract: implement `ex_14_multifile_sim_globals` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 42
;
.CODE

EXTRN ExitProcess:PROC
EXTRN ex_14_multifile_sim_globals:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_14_multifile_sim_globals in this file.
    call    ex_14_multifile_sim_globals
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
