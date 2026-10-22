; Exercise 24: from scratch rec sum array
;
; FROM SCRATCH: rec_sum(arr,n) sums n qwords. {2,3,4} n=3 -> 9.
;
; Expected exit: 9
; Expected stdout: (none)

EXTERN ExitProcess:PROC

.data
arr QWORD 2,3,4

.code
ex_24_from_scratch_rec_sum_array PROC
    sub rsp, 40
    .ALLOCSTACK 40
    .ENDPROLOG
    lea rcx, arr
    mov rdx, 3
    call rec_sum
        mov     eax, rax
    ret
    add     rsp, 40
ex_24_from_scratch_rec_sum_array ENDP
main PROC
    call    ex_24_from_scratch_rec_sum_array
    mov     rcx, rax
    call    ExitProcess
main ENDP

rec_sum PROC FRAME
    push rbx
    .PUSHREG rbx
    sub rsp, 40
    .ALLOCSTACK 40
    .ENDPROLOG
    test rdx, rdx
    jz rec_zero
    mov rbx, QWORD PTR [rcx]
    add rcx, 8
    dec rdx
    call rec_sum
    add rax, rbx
    jmp rec_done
rec_zero:
    xor rax, rax
rec_done:
    add rsp, 40
    pop rbx
    ret
rec_sum ENDP
END
