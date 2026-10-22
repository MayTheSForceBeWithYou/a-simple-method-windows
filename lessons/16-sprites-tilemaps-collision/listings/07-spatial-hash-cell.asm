; Listing 07: Spatial hash cell index
; Expected exit: 160
; Expected stdout: (none)

.CODE
EXTRN ExitProcess:PROC
main PROC
    sub rsp, 40
    mov eax, 40
    shr eax, 3
    mov ebx, eax
    mov eax, 32
    imul ebx, eax
    mov ecx, ebx
    call ExitProcess
main ENDP
END
