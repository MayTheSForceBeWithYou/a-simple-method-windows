; Exercise: 12-debug-clobber-rax
;
; BUG HUNT: Should write "X\n" then exit 0. Register set wrong before write. Fix.
; Expected exit: 0
;
.data
msg BYTE "X", 13, 10
msg_len EQU $ - msg

.data?
written DWORD ?
hStdOut QWORD ?

.code
ex_12_debug_clobber_rax PROC
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
ex_12_debug_clobber_rax ENDP
main PROC
    sub     rsp, 40
    call    ex_12_debug_clobber_rax
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
