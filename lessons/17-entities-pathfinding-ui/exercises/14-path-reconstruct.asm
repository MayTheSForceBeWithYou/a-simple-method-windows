; 14-path-reconstruct: path reconstruct
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_14_path_reconstruct:PROC
main PROC
    ; TODO: implement ex_14_path_reconstruct (student routine; defined in solutions/).
    call    ex_14_path_reconstruct
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
