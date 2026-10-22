; Exercise: 15-rip-relative
;
; Use lea rdx,[msg] (RIP-relative by default in MASM x64) to write msg 'rip\n'. Exit 0.
; Expected exit: 0
;
.data
msg BYTE "rip", 13, 10
msg_len EQU $ - msg

.data?
written DWORD ?
hStdOut QWORD ?

.code
ex_15_rip_relative PROC
    sub rsp, 56
    
    ; Get stdout handle
    mov rcx, -11
    call GetStdHandle
    mov hStdOut, rax
    
    ; Write message (RIP-relative addressing)
    mov rcx, hStdOut
    lea rdx, [msg]
    mov r8d, msg_len
    lea r9, written
    mov QWORD PTR [rsp+32], 0
    call WriteFile
    
    ; Exit 0
    mov rcx, 0
    mov     eax, 0
    add     rsp, 56
    ret
ex_15_rip_relative ENDP
main PROC
    sub     rsp, 40
    call    ex_15_rip_relative
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
