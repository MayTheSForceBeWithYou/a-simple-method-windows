; Listing 09: PE/COFF header size constant (bookkeeping stub)
; Expected exit: 64
; Expected stdout: (none)

PE_HEADER_SIZE EQU 64

.CODE
EXTRN ExitProcess:PROC

main PROC
    sub rsp, 40
    mov     ecx, PE_HEADER_SIZE
    call    ExitProcess
main ENDP
END
