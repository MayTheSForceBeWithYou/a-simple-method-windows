; Exercise 16: expr stack
;
; Shunting: push 2,3, add -> 5; exit 5.
; Expected exit: 5

EXTERN ExitProcess:PROC

.data?
st QWORD 8 DUP(?)
sp_ QWORD ?

.code
main PROC
    sub rsp, 32
    mov QWORD PTR [sp_], 0
    mov rcx, QWORD PTR [sp_]
    mov QWORD PTR [st+rcx*8], 2
    inc QWORD PTR [sp_]
    mov rcx, QWORD PTR [sp_]
    mov QWORD PTR [st+rcx*8], 3
    inc QWORD PTR [sp_]
    dec QWORD PTR [sp_]
    mov rcx, QWORD PTR [sp_]
    mov rax, QWORD PTR [st+rcx*8]
    dec QWORD PTR [sp_]
    mov rcx, QWORD PTR [sp_]
    add rax, QWORD PTR [st+rcx*8]
    mov QWORD PTR [st+rcx*8], rax
    inc QWORD PTR [sp_]
    mov rcx, rax
    call ExitProcess
main ENDP
END
