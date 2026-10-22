; Exercise: 10-macro-syscall
;
; MACRO CALL_FUNC for calling ExitProcess; Print "K\n" exit 0.
; Expected stdout: "K\n"
; Expected exit: 0
;
.data
msg BYTE "K", 10

.data?
written DWORD ?
hStdOut QWORD ?

.code
ex_10_macro_syscall PROC
    sub rsp, 56
    
    ; Get stdout handle
    mov rcx, -11
    CALL_FUNC GetStdHandle
    mov hStdOut, rax
    
    ; Write message
    mov rcx, hStdOut
    lea rdx, msg
    mov r8d, 2
    lea r9, written
    mov QWORD PTR [rsp+32], 0
    CALL_FUNC WriteFile
    
    ; Exit 0
    mov rcx, 0
    CALL_FUNC ExitProcess
ex_10_macro_syscall ENDP
main PROC
    sub     rsp, 40
    call    ex_10_macro_syscall
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
