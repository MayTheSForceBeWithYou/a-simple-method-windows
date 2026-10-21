; Listing 04: World x to tile x (>>3)
; Expected exit: 2
; Expected stdout: (none)

.CODE
EXTRN ExitProcess:PROC
main PROC
    sub rsp, 40
    mov eax, 20
    shr eax, 3
    mov ecx, eax
    call ExitProcess
main ENDP
END
