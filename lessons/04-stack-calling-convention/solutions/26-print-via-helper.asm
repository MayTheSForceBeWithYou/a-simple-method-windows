; Exercise: 26-print-via-helper
;
; Helper write_str(rcx=buf, rdx=len). Print "abi\n"; exit 0.
; Expected stdout: "abi\n"
; Expected exit: 0
;
.data
msg BYTE "abi", 13, 10
msg_len EQU $ - msg

.data?
written DWORD ?

.code
ex_26_print_via_helper PROC FRAME
    sub rsp, 40
    .ALLOCSTACK 40
    .ENDPROLOG
    lea rcx, msg
    mov rdx, msg_len
    call write_str
    xor ecx, ecx
    mov     eax, ecx
    add     rsp, 40
    ret
ex_26_print_via_helper ENDP
main PROC
    sub     rsp, 40
    call    ex_26_print_via_helper
    mov     rcx, rax
    call    ExitProcess
main ENDP

write_str PROC FRAME
    push rbx
    .PUSHREG rbx
    push rsi
    .PUSHREG rsi
    sub rsp, 40
    .ALLOCSTACK 40
    .ENDPROLOG
    mov rbx, rcx
    mov rsi, rdx
    mov rcx, -11
    call GetStdHandle
    mov rcx, rax
    mov rdx, rbx
    mov r8, rsi
    lea r9, written
    mov QWORD PTR [rsp+32], 0
    call WriteFile
    add rsp, 40
    pop rsi
    pop rbx
    ret
write_str ENDP
END
