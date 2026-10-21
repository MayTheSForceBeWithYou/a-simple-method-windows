; Listing 23: TEXTEQU token paste for exit sequence
; Expected exit: 42
; Expected stdout: (none)

EXIT_WITH_42 TEXTEQU <mov rcx, 42>

.CODE
EXTRN ExitProcess:PROC

main PROC
    sub rsp, 40
    EXIT_WITH_42
    call    ExitProcess
main ENDP
END
