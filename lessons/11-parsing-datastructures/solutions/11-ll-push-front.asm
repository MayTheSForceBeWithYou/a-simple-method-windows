; Exercise: 11-ll-push-front
;
; Push two nodes; head val=2; exit 2.
; Expected exit: 2
;
.data?
n1 QWORD 2 DUP(?)
n2 QWORD 2 DUP(?)
head QWORD ?

.code
ex_11_ll_push_front PROC
    sub rsp, 40
    mov QWORD PTR [n1], 1
    mov QWORD PTR [n1+8], 0
    lea rax, n1
    mov QWORD PTR [head], rax
    mov QWORD PTR [n2], 2
    mov rax, QWORD PTR [head]
    mov QWORD PTR [n2+8], rax
    lea rax, n2
    mov QWORD PTR [head], rax
    mov rax, QWORD PTR [head]
    mov rcx, QWORD PTR [rax]
    mov     eax, ecx
    add     rsp, 40
    ret
ex_11_ll_push_front ENDP
main PROC
    sub     rsp, 40
    call    ex_11_ll_push_front
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
