; 19-debug-q-shift
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_19_debug_q_shift:PROC
main PROC
    ; TODO: write ex_19_debug_q_shift in this file.
    call    ex_19_debug_q_shift
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
