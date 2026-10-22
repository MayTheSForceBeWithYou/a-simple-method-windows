; Exercise: 17-macro-stringize
;
; MASM text macro: write 'Q' and newline exit 0.
; Expected stdout: "Q\n"
; Expected exit: 0
;
.data
msg BYTE "Q", 10

.data?
written DWORD ?

.code
ex_17_macro_stringize PROC
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
    
    ; Exit 0
    mov rcx, 0
    mov     eax, 0
    add     rsp, 56
    ret
ex_17_macro_stringize ENDP
main PROC
    sub     rsp, 40
    call    ex_17_macro_stringize
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
