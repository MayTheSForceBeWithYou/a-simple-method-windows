; Listing 03: Tile map index y*w+x
; Expected exit: 23
; Expected stdout: (none)

.CODE
EXTRN ExitProcess:PROC
main PROC
    sub rsp, 40
    mov eax, 2
    imul eax, 10
    add eax, 3
    mov ecx, eax
    call ExitProcess
main ENDP
END
