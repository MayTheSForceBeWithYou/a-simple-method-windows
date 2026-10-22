; 17-clock-diff: clock diff
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_17_clock_diff:PROC
main PROC
    ; TODO: implement ex_17_clock_diff (student routine; defined in solutions/).
    call    ex_17_clock_diff
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
