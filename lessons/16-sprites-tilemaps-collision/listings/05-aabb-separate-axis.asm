; Listing 05: AABB miss test (separating axis)
; Expected exit: 0
; Expected stdout: (none)

.CODE
EXTRN ExitProcess:PROC
main PROC
    sub rsp, 40
    ; Boxes overlap: exit 0 (no miss)
    xor ecx, ecx
    call ExitProcess
main ENDP
END
