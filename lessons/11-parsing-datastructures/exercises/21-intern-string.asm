; 21-intern-string
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_21_intern_string:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_21_intern_string in this file.
    call    ex_21_intern_string
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
