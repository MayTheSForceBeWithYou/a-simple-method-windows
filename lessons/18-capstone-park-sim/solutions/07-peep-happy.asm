; Exercise: 07-peep-happy
;
; happiness clamp 0..100; set 120->100.
; Expected stdout: (none)
; Expected exit: 100
;
.code
ex_07_peep_happy PROC
    sub rsp, 40
    mov rax, 120
    cmp rax, 100
    jle clamp_ok
    mov rax, 100
clamp_ok:
    mov rcx, rax
    mov     eax, eax
    add     rsp, 40
    ret
ex_07_peep_happy ENDP
main PROC
    sub     rsp, 40
    call    ex_07_peep_happy
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
