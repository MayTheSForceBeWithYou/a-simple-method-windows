; Exercise: 03-astar-h
;
; Manhattan |3-1|+|4-2|=4.
; Expected stdout: (none)
;
; Contract: implement `ex_03_astar_h` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 4
;
.CODE
EXTRN ExitProcess:PROC
EXTERNDEF ex_03_astar_h:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_03_astar_h in this file.
    call    ex_03_astar_h
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
