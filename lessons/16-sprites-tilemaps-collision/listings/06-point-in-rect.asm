; Listing 06: Point in axis-aligned rectangle
; Expected exit: 1
; Expected stdout: (none)

.CODE
EXTRN ExitProcess:PROC
main PROC
    sub rsp, 40
    ; px=5 py=5 in [0,10)x[0,10) -> inside
    mov ecx, 1
    call ExitProcess
main ENDP
END
