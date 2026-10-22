; Exercise: 14-print-A
;
; Write "A\n". Exit 0.
; Expected exit: 0
;
.data
msg BYTE "A", 13, 10
msg_len EQU $ - msg

.data?
written DWORD ?
hStdOut QWORD ?

.code
ex_14_print_A PROC
    sub rsp, 56
    
    ; Get stdout handle
    mov rcx, -11
    call GetStdHandle
    mov hStdOut, rax
    
    ; Write message
    mov rcx, hStdOut
    lea rdx, msg
    mov r8d, msg_len
    lea r9, written
    mov QWORD PTR [rsp+32], 0
    call WriteFile
    
    ; Exit 0
    mov rcx, 0
    mov     eax, 0
    add     rsp, 56
    ret
ex_14_print_A ENDP
main PROC
    sub     rsp, 40
    call    ex_14_print_A
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
