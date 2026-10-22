; 20-type-check-int.asm: Check expression type is INT, exit 1 if true
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_20_type_check_int:PROC
main PROC
    ; TODO: write ex_20_type_check_int in this file.
    call    ex_20_type_check_int
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
