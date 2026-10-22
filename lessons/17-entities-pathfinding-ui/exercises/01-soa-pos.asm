; 01-soa-pos: soa pos
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_01_soa_pos:PROC
main PROC
    ; TODO: write ex_01_soa_pos in this file.
    call    ex_01_soa_pos
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
