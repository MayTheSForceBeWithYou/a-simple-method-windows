; 19-debug-null-deref-guard
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_19_debug_null_deref_guard:PROC
main PROC
    ; TODO: write ex_19_debug_null_deref_guard in this file.
    call    ex_19_debug_null_deref_guard
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
