; 03-aabb-reject: aabb reject
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_03_aabb_reject:PROC
main PROC
    ; TODO: implement ex_03_aabb_reject (student routine; defined in solutions/).
    call    ex_03_aabb_reject
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
