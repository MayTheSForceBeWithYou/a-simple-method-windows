; Demo listing
.CODE
EXTRN ExitProcess:PROC
main PROC
    xor ecx, ecx
    call ExitProcess
main ENDP
END
