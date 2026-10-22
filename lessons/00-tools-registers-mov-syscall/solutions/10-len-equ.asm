; Exercise: 10-len-equ
;
; Define string "equ works\n" with BYTE; length via EQU $ - label. Write it; exit 0.
; Expected exit: 0
;
.data
msg BYTE "equ works", 13, 10
msg_len EQU $ - msg

.data?
written DWORD ?
hStdOut QWORD ?

.code
ex_10_len_equ PROC
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
ex_10_len_equ ENDP
main PROC
    sub     rsp, 40
    call    ex_10_len_equ
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
