; Listing 10: Expanded AABB with margin (concept)
; Expected exit: 0
; Expected stdout: (none)

.CODE
EXTRN ExitProcess:PROC
main PROC
    sub     rsp, 32
    xor ecx, ecx
    call ExitProcess
main ENDP
END
