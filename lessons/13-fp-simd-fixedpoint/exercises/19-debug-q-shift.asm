; 19-debug-q-shift
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_19_debug_q_shift:PROC
main PROC
    ; TODO: implement ex_19_debug_q_shift (student routine; defined in solutions/).
    call    ex_19_debug_q_shift
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
