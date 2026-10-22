; Exercise: 05-render-line
;
; Print buffer 'ed\n'; exit 0.
; Expected stdout: "ed\n"
; Expected exit: 0
;
.data
buf BYTE "ed", 10

.data?
written DWORD ?

.code
ex_05_render_line PROC
    sub rsp, 56
    
    ; Get stdout handle
    mov rcx, -11
    call GetStdHandle
    
    ; Write buffer
    mov rcx, rax
    lea rdx, buf
    mov r8d, 3
    lea r9, written
    mov QWORD PTR [rsp+32], 0
    call WriteFile
    
    ; Exit 0
    mov rcx, 0
    mov     eax, 0
    add     rsp, 56
    ret
ex_05_render_line ENDP
main PROC
    sub     rsp, 40
    call    ex_05_render_line
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
