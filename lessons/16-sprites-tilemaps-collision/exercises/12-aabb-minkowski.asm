; 12-aabb-minkowski: aabb minkowski
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_12_aabb_minkowski:PROC
main PROC
    ; TODO: write ex_12_aabb_minkowski in this file.
    call    ex_12_aabb_minkowski
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
