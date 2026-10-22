; Exercise: 05-entity-alive
;
; flags bit0 alive; exit 1.
; Expected stdout: (none)
; Expected exit: 1
;
.data
flags BYTE 1

.code
ex_05_entity_alive PROC
    sub rsp, 40
    movzx rcx, BYTE PTR [flags]
    and rcx, 1
    mov     eax, ecx
    add     rsp, 40
    ret
ex_05_entity_alive ENDP
main PROC
    sub     rsp, 40
    call    ex_05_entity_alive
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
