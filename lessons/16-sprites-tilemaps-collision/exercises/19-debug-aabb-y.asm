; 19-debug-aabb-y: debug aabb y
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_19_debug_aabb_y:PROC
main PROC
    ; TODO: implement ex_19_debug_aabb_y (student routine; defined in solutions/).
    call    ex_19_debug_aabb_y
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
