; Exercise: 08-from-scratch-gap-start
;
; FROM SCRATCH: gap buffer indices gap_start=0 gap_end=8 capacity 8 empty; exit gap_end-gap_start (=8 free).
; Expected exit: 8
;
.data?
gap_s QWORD ?
gap_e QWORD ?

.code
ex_08_from_scratch_gap_start PROC
    sub rsp, 40
    
    mov QWORD PTR [gap_s], 0
    mov QWORD PTR [gap_e], 8
    
    mov rcx, [gap_e]
    sub rcx, [gap_s]
    mov     eax, ecx
    add     rsp, 40
    ret
ex_08_from_scratch_gap_start ENDP
main PROC
    sub     rsp, 40
    call    ex_08_from_scratch_gap_start
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
