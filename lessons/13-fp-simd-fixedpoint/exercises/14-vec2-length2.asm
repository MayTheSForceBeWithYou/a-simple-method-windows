; 14-vec2-length2
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_14_vec2_length2:PROC
main PROC
    ; TODO: implement ex_14_vec2_length2 (student routine; defined in solutions/).
    call    ex_14_vec2_length2
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
