; Exercise 18: guest happiness
;
; Clamp happiness add 20 from 90 -> 100; exit 100.
;
; Expected exit: 100
; Expected stdout: (none)

EXTERN ExitProcess:PROC

.code

ex_18_guest_happiness PROC
mov rax, 90
    add rax, 20
    cmp rax, 100
    jle happy_ok
    mov rax, 100
happy_ok:
    mov rcx, rax
    ret
ex_18_guest_happiness ENDP
main PROC
    sub     rsp, 40
    call    ex_18_guest_happiness
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
