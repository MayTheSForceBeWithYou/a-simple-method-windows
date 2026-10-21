; Listing 15: Ring buffer tail wrap mask (LESSON.md block 15)
; Expected exit: 0
; Expected stdout: (none)

.DATA?
tail QWORD ?

.CODE
EXTRN ExitProcess:PROC

main PROC
    sub     rsp, 32
    mov     tail, 3
    inc     tail
    and     tail, 3
    mov     ecx, DWORD PTR tail
    call    ExitProcess
main ENDP
END
