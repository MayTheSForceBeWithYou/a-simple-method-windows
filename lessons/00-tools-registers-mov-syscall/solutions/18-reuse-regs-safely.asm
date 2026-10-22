; Exercise: 18-reuse-regs-safely
;
; Write "ok\n", then exit 0. Re-load parameters after write (registers may be clobbered).
; Expected exit: 0
;
.data
msg BYTE "ok", 13, 10
msg_len EQU $ - msg

.data?
written DWORD ?
hStdOut QWORD ?

.code
ex_18_reuse_regs_safely PROC
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
ex_18_reuse_regs_safely ENDP
main PROC
    sub     rsp, 40
    call    ex_18_reuse_regs_safely
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
