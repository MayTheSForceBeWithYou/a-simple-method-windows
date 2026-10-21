; Listing 07: Push front onto intrusive list (LESSON.md block 7)
; Expected exit: 2
; Expected stdout: (none)

.DATA?
head QWORD ?
node1 DQ 2 DUP(?)
node2 DQ 2 DUP(?)

.CODE
EXTRN ExitProcess:PROC

main PROC
    mov     QWORD PTR node1, 1
    mov     QWORD PTR node1[8], 0
    mov     rax, head
    mov     QWORD PTR node1[8], rax
    lea     rax, node1
    mov     head, rax

    mov     QWORD PTR node2, 2
    mov     rax, head
    mov     QWORD PTR node2[8], rax
    lea     rax, node2
    mov     head, rax

    mov     rsi, head
    mov     rax, [rsi]
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
