; Exercise 09: spawn entity
;
; Bump entity id; first spawn id=1; exit 1.
;
; Expected exit: 1
; Expected stdout: (none)

EXTERN ExitProcess:PROC

.data
next_id QWORD 0

.code
ex_09_spawn_entity PROC
    sub rsp, 40
    inc QWORD PTR [next_id]
        mov     eax, QWORD PTR [next_id]
    add     rsp, 40
    ret
ex_09_spawn_entity ENDP
main PROC
    call    ex_09_spawn_entity
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
