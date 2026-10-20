; Exercise 15: rd expect
;
; Expect char "(" present; exit 1.
; Expected exit: 1

EXTERN ExitProcess:PROC

.data
s BYTE "(1)", 0

.code
main PROC
    sub rsp, 32
    cmp BYTE PTR [s], '('
    jne not_found
    mov rcx, 1
    jmp done
not_found:
    xor rcx, rcx
done:
    call ExitProcess
main ENDP
END
