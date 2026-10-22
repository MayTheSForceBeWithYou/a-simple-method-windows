; Exercise 23: stretch error span
;
; STRETCH: error at offset 4 length 1; exit 4.
; Expected exit: 4

EXTERN ExitProcess:PROC

.data?
err_off QWORD ?

.code

ex_23_stretch_error_span PROC
sub rsp, 40
    mov QWORD PTR [err_off], 4
    mov     eax, 4
    ret
ex_23_stretch_error_span ENDP
main PROC
    sub     rsp, 40
    call    ex_23_stretch_error_span
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
