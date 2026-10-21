; Listing 12: Direct-index hash table slot (LESSON.md block 12)
; Expected exit: 42
; Expected stdout: (none)

.DATA?
slots DQ 4 DUP(?)

.CODE
EXTRN ExitProcess:PROC

main PROC
    sub     rsp, 32
    mov     QWORD PTR slots[16], 42
    mov     rax, slots[16]
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
