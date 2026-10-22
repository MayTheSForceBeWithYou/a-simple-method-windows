; Exercise 06: aos sum
; AoS records {x,y}. Two ents (1,2), (3,4). Sum all=10.
; Expected exit: 10

EXTERN ExitProcess:PROC

.data
rec QWORD 1,2, 3,4

.code
ex_06_aos_sum PROC
    sub rsp, 40
    xor rcx, rcx
    add rcx, rec[0]
    add rcx, rec[8]
    add rcx, rec[16]
    add rcx, rec[24]
    mov     eax, 10
    ret
ex_06_aos_sum ENDP
main PROC
    call    ex_06_aos_sum
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
