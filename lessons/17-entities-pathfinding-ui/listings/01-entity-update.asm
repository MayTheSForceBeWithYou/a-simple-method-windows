; Update entity position, exit new x
.DATA?
entity_x QWORD ?
entity_vx QWORD ?
.CODE
EXTRN ExitProcess:PROC
main PROC
    sub rsp, 40
    mov entity_x, 100
    mov entity_vx, 5
    mov rax, entity_x
    add rax, entity_vx
    mov entity_x, rax
    mov ecx, eax
    call ExitProcess
main ENDP
END
