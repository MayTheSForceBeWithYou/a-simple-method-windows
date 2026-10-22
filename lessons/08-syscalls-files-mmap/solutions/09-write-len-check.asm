; Exercise: 09-write-len-check
;
; write "Z\n"; if written==2 exit 0 else 1.
; Expected stdout: "Z\n"
; Expected exit: 0
;
.data
msg BYTE "Z", 10

.data?
written DWORD ?

.code
ex_09_write_len_check PROC
    sub rsp, 56
    
    ; Get stdout handle
    mov rcx, -11
    call GetStdHandle
    
    ; Write message
    mov rcx, rax
    lea rdx, msg
    mov r8d, 2
    lea r9, written
    mov QWORD PTR [rsp+32], 0
    call WriteFile
    
    ; Check if 2 bytes were written
    cmp written, 2
    jne L_bad
    
    ; Success - exit 0
    mov rcx, 0
    jmp L_o
    
L_bad:
    ; Failure - exit 1
    mov rcx, 1
    
L_o:
    mov     eax, ecx
    add     rsp, 56
    ret
ex_09_write_len_check ENDP
main PROC
    sub     rsp, 40
    call    ex_09_write_len_check
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
