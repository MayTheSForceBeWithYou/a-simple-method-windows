; Exercise: 13-astar-fscore
;
; Exercise 13: astar fscore
; f=g+h; g=3 h=4; exit 7.
; Expected stdout: (none)
;
; Contract: implement `ex_13_astar_fscore` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 7
;

; 13-astar-fscore: astar fscore
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_13_astar_fscore:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_13_astar_fscore in this file.
    call    ex_13_astar_fscore
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
