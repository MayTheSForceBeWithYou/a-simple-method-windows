; 02-aabb-overlap: aabb overlap
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_02_aabb_overlap:PROC
main PROC
    ; TODO: write ex_02_aabb_overlap in this file.
    call    ex_02_aabb_overlap
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
