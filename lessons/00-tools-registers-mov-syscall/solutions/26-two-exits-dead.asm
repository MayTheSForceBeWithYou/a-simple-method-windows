; Exercise: 26-two-exits-dead
;
; Write "alive\n", exit 0, then dead exit 99 after (unreachable).
; Expected exit: 0
;
.data
msg BYTE "alive", 13, 10
msg_len EQU $ - msg

.data?
written DWORD ?
hStdOut QWORD ?

.code
ex_26_two_exits_dead PROC
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
    ; Dead code (unreachable)
    mov rcx, 99
    mov     eax, 99
    ret
ex_26_two_exits_dead ENDP
main PROC
    sub     rsp, 40
    call    ex_26_two_exits_dead
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
