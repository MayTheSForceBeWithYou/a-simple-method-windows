; Listing 07: Walk parent array one step (LESSON.md block 7)
; Expected exit: 2
; Expected stdout: (none)

.DATA?
agent_pos QWORD ?
parent DQ 8 DUP(?)

.CODE
EXTRN ExitProcess:PROC

main PROC
    sub rsp, 40
    lea     r10, parent
    mov     agent_pos, 5
    mov     QWORD PTR [r10+5*8], 2
    mov     rax, agent_pos
    mov     rbx, QWORD PTR [r10+rax*8]
    mov     agent_pos, rbx
    mov     ecx, ebx
    call    ExitProcess
main ENDP
END
