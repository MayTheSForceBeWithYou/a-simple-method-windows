; Exercise: 02-insert-char
;
; Insert 'A' at end; len=1; exit 1.
; Expected exit: 1
;
.data?
buf BYTE 64 DUP(?)
len QWORD ?

.code
ex_02_insert_char PROC
    sub rsp, 40
    
    mov QWORD PTR [len], 0
    mov rcx, [len]
    lea rdx, buf
    mov BYTE PTR [rdx+rcx], 'A'
    inc QWORD PTR [len]
    
    mov rcx, [len]
    mov     eax, ecx
    add     rsp, 40
    ret
ex_02_insert_char ENDP
main PROC
    sub     rsp, 40
    call    ex_02_insert_char
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
