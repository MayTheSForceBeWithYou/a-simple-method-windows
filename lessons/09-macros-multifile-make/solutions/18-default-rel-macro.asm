; Exercise: 18-default-rel-macro
;
; MASM RIP-relative addressing (default in 64-bit); lea rdx,[msg]; write hi; exit 0.
; Expected stdout: "hi\n"
; Expected exit: 0
;
.data
msg BYTE "hi", 10
msg_len EQU $ - msg

.data?
written DWORD ?

.code
ex_18_default_rel_macro PROC
    sub rsp, 56
    
    ; Get stdout handle
    mov rcx, -11
    call GetStdHandle
    
    ; Write message (MASM uses RIP-relative by default)
    mov rcx, rax
    lea rdx, [msg]      ; RIP-relative addressing is automatic in MASM x64
    mov r8d, msg_len
    lea r9, written
    mov QWORD PTR [rsp+32], 0
    call WriteFile
    
    ; Exit 0
    mov rcx, 0
    mov     eax, 0
    add     rsp, 56
    ret
ex_18_default_rel_macro ENDP
main PROC
    sub     rsp, 40
    call    ex_18_default_rel_macro
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
