; 21-intern-string
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_21_intern_string:PROC
main PROC
    ; TODO: implement ex_21_intern_string (student routine; defined in solutions/).
    call    ex_21_intern_string
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
