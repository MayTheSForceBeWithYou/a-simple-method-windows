; Exercise: 03-macro-write
;
; Macro write_stdout msg,len; print 'M\n'.
; Expected stdout: "M\n"
; Expected exit: 0
;
    .data?
    written DWORD ?
    hStdOut QWORD ?
    .code
    
    ; Get stdout handle
    mov rcx, -11
    call GetStdHandle
    mov hStdOut, rax
    
    ; Write message
    mov rcx, hStdOut
    lea rdx, msg
    mov r8d, len
    lea r9, written
    mov QWORD PTR [rsp+32], 0
    call WriteFile
ENDM

.data
m BYTE "M", 10

.code
ex_03_macro_write PROC
    sub rsp, 56
    
    write_stdout m, 2
    
    ; Exit 0
    mov rcx, 0
    mov     eax, 0
    add     rsp, 56
    ret
ex_03_macro_write ENDP
main PROC
    sub     rsp, 40
    call    ex_03_macro_write
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
