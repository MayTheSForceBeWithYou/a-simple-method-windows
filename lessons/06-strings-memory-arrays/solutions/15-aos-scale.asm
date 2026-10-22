; Exercise 15: aos scale
; {3,4}*2 -> {6,8}; sum=14.
; Expected exit: 14

EXTERN ExitProcess:PROC

.data
ent QWORD 3,4

.code
ex_15_aos_scale PROC
    sub rsp, 40
    shl ent, 1
    shl ent[8], 1
    mov rcx, ent
    add rcx, ent[8]
    mov     eax, 14
    ret
ex_15_aos_scale ENDP
main PROC
    call    ex_15_aos_scale
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
