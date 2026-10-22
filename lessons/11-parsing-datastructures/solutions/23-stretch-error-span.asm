; Exercise: 23-stretch-error-span
;
; STRETCH: error at offset 4 length 1; exit 4.
; Expected exit: 4
;
.data?
err_off QWORD ?

.code
ex_23_stretch_error_span PROC
    sub rsp, 40
    mov QWORD PTR [err_off], 4
    mov rcx, QWORD PTR [err_off]
    mov     eax, ecx
    add     rsp, 40
    ret
ex_23_stretch_error_span ENDP
main PROC
    sub     rsp, 40
    call    ex_23_stretch_error_span
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
