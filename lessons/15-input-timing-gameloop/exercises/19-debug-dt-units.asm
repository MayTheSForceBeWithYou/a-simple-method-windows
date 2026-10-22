; 19-debug-dt-units: debug dt units
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_19_debug_dt_units:PROC
main PROC
    ; TODO: implement ex_19_debug_dt_units (student routine; defined in solutions/).
    call    ex_19_debug_dt_units
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
