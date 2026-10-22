; Exercise: 18-status-line-len
;
; Status encodes len=12; exit 12.
; Expected exit: 12
;
.data?
len QWORD ?

.code
ex_18_status_line_len PROC
    sub rsp, 40
    
    mov QWORD PTR [len], 12
    mov rcx, [len]
    mov     eax, ecx
    add     rsp, 40
    ret
ex_18_status_line_len ENDP
main PROC
    sub     rsp, 40
    call    ex_18_status_line_len
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
