; Exercise: 17-duplicate-handle
;
; Without DuplicateHandle: write to stdout; exit 0. Documents handle reuse.
; Expected stdout: "d\n"
; Expected exit: 0
;
.data
msg BYTE "d", 10

.data?
written DWORD ?

.code
ex_17_duplicate_handle PROC
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
ex_17_duplicate_handle ENDP
main PROC
    sub     rsp, 40
    call    ex_17_duplicate_handle
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
