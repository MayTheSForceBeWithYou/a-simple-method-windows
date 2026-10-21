; Listing 14: FIFO queue enqueue/dequeue (LESSON.md block 14)
; Expected exit: 7
; Expected stdout: (none)

.DATA?
q DQ 4 DUP(?)
head QWORD ?
tail QWORD ?

.CODE
EXTRN ExitProcess:PROC

main PROC
    mov     head, 0
    mov     tail, 0
    mov     rdi, 7
    mov     rcx, tail
    mov     q[rcx*8], rdi
    inc     tail
    mov     rdi, 8
    mov     rcx, tail
    mov     q[rcx*8], rdi
    inc     tail
    mov     rcx, head
    mov     rax, q[rcx*8]
    inc     head
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
