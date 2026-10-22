; Exercise: 16-soa-sum
;
; SoA xs={1,2,3} ys={4,5,6}; sum all 21.
; Expected stdout: (none)
; Expected exit: 21
;
.data
xs QWORD 1,2,3
ys QWORD 4,5,6

.code
ex_16_soa_sum PROC
    sub rsp, 40
    mov rcx, QWORD PTR [xs]
    add rcx, QWORD PTR [xs+8]
    add rcx, QWORD PTR [xs+16]
    add rcx, QWORD PTR [ys]
    add rcx, QWORD PTR [ys+8]
    add rcx, QWORD PTR [ys+16]
    mov     eax, ecx
    add     rsp, 40
    ret
ex_16_soa_sum ENDP
main PROC
    sub     rsp, 40
    call    ex_16_soa_sum
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
