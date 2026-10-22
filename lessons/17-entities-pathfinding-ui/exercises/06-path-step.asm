; 06-path-step: path step
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_06_path_step:PROC
main PROC
    ; TODO: implement ex_06_path_step (student routine; defined in solutions/).
    call    ex_06_path_step
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
