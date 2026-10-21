; Listing 16: AST node field layout (LESSON.md block 16)
; Expected exit: 6
; Expected stdout: (none)

.DATA?
node_kind QWORD ?
node_left QWORD ?
node_right QWORD ?

.CODE
EXTRN ExitProcess:PROC

main PROC
    sub rsp, 40
    mov     node_kind, 1
    mov     node_left, 2
    mov     node_right, 3
    mov     rax, node_kind
    add     rax, node_left
    add     rax, node_right
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
