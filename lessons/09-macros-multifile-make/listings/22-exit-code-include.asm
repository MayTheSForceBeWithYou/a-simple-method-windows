; Listing 22: INCLUDE shared header (12-* topic; pairs with 22-exit-code.inc)
; Expected exit: 0
; Expected stdout: (none)

INCLUDE 22-exit-code.inc

.CODE
EXTRN ExitProcess:PROC

main PROC
    sub rsp, 40
    mov     ecx, EXIT_OK
    call    ExitProcess
main ENDP
END
