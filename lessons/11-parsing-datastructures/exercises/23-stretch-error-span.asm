; 23-stretch-error-span
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_23_stretch_error_span:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_23_stretch_error_span in this file.
    call    ex_23_stretch_error_span
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
