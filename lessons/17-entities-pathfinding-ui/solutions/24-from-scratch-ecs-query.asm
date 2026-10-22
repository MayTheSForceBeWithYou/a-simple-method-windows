; Exercise 24: from scratch ecs query
;
; FROM SCRATCH: count entities with mask POS; 3 of 4; exit 3.
;
; Expected exit: 3
; Expected stdout: (none)

EXTERN ExitProcess:PROC

.data
masks BYTE 1,1,1,0

.code
ex_24_from_scratch_ecs_query PROC
    sub rsp, 40
    xor r8, r8
    xor r9, r9
query_loop:
    cmp r9, 4
    jge query_done
    lea r11, [masks]
    movzx rax, BYTE PTR [r11+r9]
    test rax, 1
    jz query_next
    inc r8
query_next:
    inc r9
    jmp query_loop
query_done:
    call ExitProcess
    mov     eax, r8d
    add     rsp, 40
    ret
ex_24_from_scratch_ecs_query ENDP
main PROC
    sub     rsp, 40
    call    ex_24_from_scratch_ecs_query
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
