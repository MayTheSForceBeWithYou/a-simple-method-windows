; Exercise: 20-label-addresses
;
; Two messages; print only msg2 "use me\n". Exit 0.
; Expected exit: 0
;
.data
msg1 BYTE "skip", 13, 10
msg2 BYTE "use me", 13, 10
msg2_len EQU $ - msg2

.data?
written DWORD ?
hStdOut QWORD ?

.code
ex_20_label_addresses PROC
    sub rsp, 56
    
    ; Get stdout handle
    mov rcx, -11
    call GetStdHandle
    mov hStdOut, rax
    
    ; Write msg2
    mov rcx, hStdOut
    lea rdx, msg2
    mov r8d, msg2_len
    lea r9, written
    mov QWORD PTR [rsp+32], 0
    call WriteFile
    
    ; Exit 0
    mov rcx, 0
    mov     eax, 0
    add     rsp, 56
    ret
ex_20_label_addresses ENDP
main PROC
    sub     rsp, 40
    call    ex_20_label_addresses
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
