; 17-clock-diff: clock diff
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_17_clock_diff:PROC
main PROC
    ; TODO: write ex_17_clock_diff in this file.
    call    ex_17_clock_diff
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
