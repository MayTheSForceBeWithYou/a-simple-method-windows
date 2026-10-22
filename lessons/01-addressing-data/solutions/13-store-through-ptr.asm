; Exercise: 13-store-through-ptr
;
; lea rdx,[slot]; mov QWORD PTR [rdx], 77; mov rcx,[slot]; exit.
; Expected exit: 77
;
.data?
slot QWORD ?

.code
ex_13_store_through_ptr PROC
    sub rsp, 40
    lea rdx, [slot]
    mov QWORD PTR [rdx], 77
    mov rcx, [slot]
    mov     eax, ecx
    add     rsp, 40
    ret
ex_13_store_through_ptr ENDP
main PROC
    sub     rsp, 40
    call    ex_13_store_through_ptr
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
