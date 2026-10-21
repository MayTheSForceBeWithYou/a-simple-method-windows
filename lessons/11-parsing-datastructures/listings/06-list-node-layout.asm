; Listing 06: Singly-linked node layout (LESSON.md block 6)
; Expected exit: 9
; Expected stdout: (none)

.DATA?
node_value QWORD ?
node_next QWORD ?

.CODE
EXTRN ExitProcess:PROC

main PROC
    sub     rsp, 32
    mov     node_value, 9
    mov     node_next, 0
    mov     ecx, 9
    call    ExitProcess
main ENDP
END
