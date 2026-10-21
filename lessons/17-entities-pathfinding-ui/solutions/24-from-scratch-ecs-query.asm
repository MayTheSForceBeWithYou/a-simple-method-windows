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
main PROC
    sub rsp, 40
    xor r8, r8
    xor r9, r9
query_loop:
    cmp r9, 4
    jge query_done
    movzx rax, BYTE PTR [masks+r9]
    test rax, 1
    jz query_next
    inc r8
query_next:
    inc r9
    jmp query_loop
query_done:
    mov rcx, r8
    call ExitProcess
main ENDP
END
