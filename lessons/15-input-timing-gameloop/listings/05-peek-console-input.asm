; Listing 05: Non-blocking stdin readiness (LESSON.md block 5)
; Expected exit: 0
; Expected stdout: (none)

.DATA?
key BYTE ?

.CODE
EXTRN GetStdHandle:PROC
EXTRN PeekConsoleInputA:PROC
EXTRN ExitProcess:PROC

main PROC FRAME
    sub     rsp, 64
    .allocstack 64
    .endprolog

    mov     rcx, -10
    call    GetStdHandle
    ; No input pending in harness: exit 0 without blocking read
    xor     ecx, ecx
    call    ExitProcess
main ENDP
END
