; Listing 21: First-style EQU constant (fills missing 01-* topic)
; Expected exit: 0
; Expected stdout: (none)

STATUS_OK EQU 0

.CODE
EXTRN ExitProcess:PROC

main PROC
    sub rsp, 40
    mov     ecx, STATUS_OK
    call    ExitProcess
main ENDP
END
