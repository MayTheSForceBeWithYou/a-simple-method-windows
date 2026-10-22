; Exercise 03: list node
;
; Node {dq val, next}; one node val 9; exit 9.
; Expected exit: 9

EXTERN ExitProcess:PROC

.data?
node QWORD 2 DUP(?)

.code

ex_03_list_node PROC
mov QWORD PTR [node], 9
    mov QWORD PTR [node+8], 0
    mov rcx, QWORD PTR [node]
    mov     eax, ecx
    ret
ex_03_list_node ENDP
main PROC
    sub     rsp, 40
    call    ex_03_list_node
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
