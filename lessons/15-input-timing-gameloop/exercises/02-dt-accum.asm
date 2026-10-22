; 02-dt-accum: dt accum
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_02_dt_accum:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_02_dt_accum in this file.
    call    ex_02_dt_accum
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
