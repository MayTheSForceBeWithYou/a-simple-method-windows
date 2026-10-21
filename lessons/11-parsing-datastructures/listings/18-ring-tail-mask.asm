; Listing 18: Tail index wrap with mask (LESSON.md block 18)
; Expected exit: 3
; Expected stdout: (none)

.DATA?
tail QWORD ?

.CODE
EXTRN ExitProcess:PROC

main PROC
    sub     rsp, 32
    mov     tail, 7
    and     tail, 3
    mov     ecx, DWORD PTR tail
    call    ExitProcess
main ENDP
END
