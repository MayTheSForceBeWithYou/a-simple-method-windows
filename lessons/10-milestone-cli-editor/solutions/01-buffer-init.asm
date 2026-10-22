; Exercise: 01-buffer-init
;
; Allocate 64 byte buffer; store length 0 in len; exit len.
; Expected exit: 0
;
.data?
buf BYTE 64 DUP(?)
len QWORD ?

.code
ex_01_buffer_init PROC
    sub rsp, 40
    
    mov QWORD PTR [len], 0
    mov rcx, [len]
    mov     eax, ecx
    add     rsp, 40
    ret
ex_01_buffer_init ENDP
main PROC
    sub     rsp, 40
    call    ex_01_buffer_init
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
