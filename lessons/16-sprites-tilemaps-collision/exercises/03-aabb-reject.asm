; 03-aabb-reject: aabb reject
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_03_aabb_reject:PROC
main PROC
    ; TODO: write ex_03_aabb_reject in this file.
    call    ex_03_aabb_reject
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
