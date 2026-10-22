; Listing 08: Chunk coordinate from tile
; Expected exit: 2
; Expected stdout: (none)

.CODE
EXTRN ExitProcess:PROC
main PROC
    sub rsp, 40
    mov eax, 40
    shr eax, 4
    mov ecx, eax
    call ExitProcess
main ENDP
END
