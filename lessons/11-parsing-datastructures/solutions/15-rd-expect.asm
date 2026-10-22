; Exercise 15: rd expect
;
; Expect char "(" present; exit 1.
; Expected exit: 1

EXTERN ExitProcess:PROC

.data
s BYTE "(1)", 0

.code
ex_15_rd_expect PROC
    sub rsp, 40
    cmp BYTE PTR [s], '('
    jne not_found
    mov rcx, 1
    jmp done
not_found:
    xor rcx, rcx
done:
    mov     eax, ecx
    add     rsp, 40
    ret
ex_15_rd_expect ENDP
main PROC
    sub     rsp, 40
    call    ex_15_rd_expect
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
