; Exercise: 01-write-only
;
; Review write; print 'io\n'; exit 0.
; Expected stdout: "io\n"
; Expected exit: 0
;
.data
msg BYTE "io", 10
msg_len EQU $ - msg

.data?
written DWORD ?

.code
ex_01_write_only PROC
    sub rsp, 56
    
    ; Get stdout handle
    mov rcx, -11
    call GetStdHandle
    
    ; Write message
    mov rcx, rax
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
ex_01_write_only ENDP
main PROC
    sub     rsp, 40
    call    ex_01_write_only
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
