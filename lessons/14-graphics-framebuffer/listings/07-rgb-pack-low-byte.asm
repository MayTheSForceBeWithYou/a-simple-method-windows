; Listing 07: Pack R,G,B into dword; exit blue channel
; Expected exit: 3
; Expected stdout: (none)

.CODE
EXTRN ExitProcess:PROC

main PROC
    sub rsp, 40
    mov     eax, 1
    shl     eax, 16
    mov     ebx, 2
    shl     ebx, 8
    or      eax, ebx
    or      eax, 3
    and     eax, 0FFh
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
