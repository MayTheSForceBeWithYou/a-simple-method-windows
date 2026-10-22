; Exercise: 13-peep-pathfind-step
;
; Exercise 13: peep pathfind step
; Peep follows path; steps remaining 4; exit 4.
; Expected stdout: (none)
;
; Contract: implement `ex_13_peep_pathfind_step` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 4
;

; 13-peep-pathfind-step: peep pathfind step
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_13_peep_pathfind_step:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_13_peep_pathfind_step in this file.
    call    ex_13_peep_pathfind_step
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
