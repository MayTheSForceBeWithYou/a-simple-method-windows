; 01-soa-pos: soa pos
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_01_soa_pos:PROC
main PROC
    ; TODO: implement ex_01_soa_pos (student routine; defined in solutions/).
    call    ex_01_soa_pos
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
