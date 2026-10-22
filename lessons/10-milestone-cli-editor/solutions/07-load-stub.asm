; Exercise: 07-load-stub
;
; Pretend load sets len=3; exit 3.
; Expected exit: 3
;
.data?
len QWORD ?

.code
ex_07_load_stub PROC
    sub rsp, 40
    
    mov QWORD PTR [len], 3
    mov rcx, [len]
    mov     eax, ecx
    add     rsp, 40
    ret
ex_07_load_stub ENDP
main PROC
    sub     rsp, 40
    call    ex_07_load_stub
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
