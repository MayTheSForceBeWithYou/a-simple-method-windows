; Exercise 14: codegen add regs
;
; v1=10 v2=32; add into v1; exit 42.
; Expected exit: 42

EXTERN ExitProcess:PROC

.data?
v1 QWORD ?
v2 QWORD ?

.code
main PROC
    sub rsp, 32
    mov QWORD PTR [v1], 10
    mov QWORD PTR [v2], 32
    mov rax, QWORD PTR [v1]
    add rax, QWORD PTR [v2]
    mov QWORD PTR [v1], rax
    mov rcx, rax
    call ExitProcess
main ENDP
END
