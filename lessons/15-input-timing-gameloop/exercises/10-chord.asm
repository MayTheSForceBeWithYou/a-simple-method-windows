; Exercise: 10-chord
;
; W and Shift both down -> run=1; exit 1.
; Expected stdout: (none)
;
; Contract: implement `ex_10_chord` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 1
;
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_10_chord:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_10_chord in this file.
    call    ex_10_chord
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
