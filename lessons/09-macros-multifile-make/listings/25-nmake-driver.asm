; Listing 25: Program built via NMake (see Makefile.mak in this directory)
; Expected exit: 0
; Expected stdout: (none)

.CODE
EXTRN ExitProcess:PROC

main PROC
    sub rsp, 40
    xor     ecx, ecx
    call    ExitProcess
main ENDP
END
