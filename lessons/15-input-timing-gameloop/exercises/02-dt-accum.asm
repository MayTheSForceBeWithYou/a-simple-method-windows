; 02-dt-accum: dt accum
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_02_dt_accum:PROC
main PROC
    ; TODO: implement ex_02_dt_accum (student routine; defined in solutions/).
    call    ex_02_dt_accum
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
