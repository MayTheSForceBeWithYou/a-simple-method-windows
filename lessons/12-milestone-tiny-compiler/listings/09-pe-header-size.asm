; Listing 09: Sum IMAGE_DOS_HEADER field sizes (PE bookkeeping)
; Expected exit: 64
; Expected stdout: (none)

.CODE
EXTRN ExitProcess:PROC

main PROC
    sub rsp, 40
    xor     ecx, ecx
    mov     eax, 14
    shl     eax, 1
    add     ecx, eax
    add     ecx, 8
    add     ecx, 4
    add     ecx, 20
    add     ecx, 4
    call    ExitProcess
main ENDP
END
