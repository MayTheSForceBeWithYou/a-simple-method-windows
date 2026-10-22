; 19-debug-aabb-y: debug aabb y
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_19_debug_aabb_y:PROC
main PROC
    ; TODO: write ex_19_debug_aabb_y in this file.
    call    ex_19_debug_aabb_y
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
