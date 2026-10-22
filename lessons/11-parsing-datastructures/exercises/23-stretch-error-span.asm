; 23-stretch-error-span
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_23_stretch_error_span:PROC
main PROC
    ; TODO: implement ex_23_stretch_error_span (student routine; defined in solutions/).
    call    ex_23_stretch_error_span
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
