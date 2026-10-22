; Exercise 18: fixed angle step
;
; Angle += delta; wrap 360; 350+20 -> 10; exit 10.
; Expected exit: 10

EXTERN ExitProcess:PROC

.code
ex_18_fixed_angle_step PROC
    sub rsp, 40
    mov rax, 350
    add rax, 20
loop_wrap:
    cmp rax, 360
    jl done_wrap
    sub rax, 360
    jmp loop_wrap
done_wrap:
        mov     eax, rax
    ret

ex_18_fixed_angle_step ENDP
main PROC
    call    ex_18_fixed_angle_step
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
