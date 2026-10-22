; 19-debug-null-deref-guard
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_19_debug_null_deref_guard:PROC
main PROC
    ; TODO: implement ex_19_debug_null_deref_guard (student routine; defined in solutions/).
    call    ex_19_debug_null_deref_guard
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
