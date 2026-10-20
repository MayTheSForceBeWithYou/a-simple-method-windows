; Exercise 03: parse let
;
; Recognize keyword first letter 'l' of let; exit 1.
; Expected exit: 1

EXTERN ExitProcess:PROC

.data
kw BYTE "let", 0

.code
main PROC
    sub rsp, 32
    cmp BYTE PTR [kw], 'l'
    jne not_l
    mov rcx, 1
    jmp done
not_l:
    xor rcx, rcx
done:
    call ExitProcess
main ENDP
END
