; Listing 13: Sleep remaining frame budget (0 ms pad)
; Expected exit: 0
; Expected stdout: (none)

.CODE
EXTRN Sleep:PROC
EXTRN ExitProcess:PROC

main PROC FRAME
    sub rsp, 40
    .allocstack 40
    .endprolog
    xor     ecx, ecx
    call    Sleep
    xor     ecx, ecx
    call    ExitProcess
main ENDP
END
