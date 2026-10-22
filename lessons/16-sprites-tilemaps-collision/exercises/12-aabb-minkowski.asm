; 12-aabb-minkowski: aabb minkowski
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_12_aabb_minkowski:PROC
main PROC
    ; TODO: implement ex_12_aabb_minkowski (student routine; defined in solutions/).
    call    ex_12_aabb_minkowski
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
