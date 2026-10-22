; Listing 17: Queue enqueue/dequeue sequence (LESSON.md block 17)
; Expected exit: 7
; Expected stdout: (none)

.DATA?
q DQ 4 DUP(?)
head QWORD ?
tail QWORD ?

.CODE
EXTRN ExitProcess:PROC

main PROC
    sub rsp, 40
    lea     r10, q
    mov     head, 0
    mov     tail, 0
    mov     rcx, tail
    mov     QWORD PTR [r10+rcx*8], 7
    inc     tail
    mov     rcx, tail
    mov     QWORD PTR [r10+rcx*8], 8
    inc     tail
    mov     rcx, head
    mov     rax, QWORD PTR [r10+rcx*8]
    inc     head
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
