; Exercise 03: parse let
;
; Recognize keyword first letter 'l' of let; exit 1.
; Expected exit: 1

EXTERN ExitProcess:PROC

.data
kw BYTE "let", 0

.code
ex_03_parse_let PROC
    sub rsp, 40
    cmp BYTE PTR [kw], 'l'
    jne not_l
    mov rcx, 1
    jmp done
not_l:
    xor rcx, rcx
done:
    mov     eax, ecx
    add     rsp, 40
    ret
ex_03_parse_let ENDP
main PROC
    sub     rsp, 40
    call    ex_03_parse_let
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
