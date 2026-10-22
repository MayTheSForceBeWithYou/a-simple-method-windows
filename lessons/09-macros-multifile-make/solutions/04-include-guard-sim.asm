; Exercise: 04-include-guard-sim
;
; Use IFNDEF/ENDIF for ANSWER equ 42; exit 42.
; Expected exit: 42
;
.code
ex_04_include_guard_sim PROC
    sub rsp, 40
    mov rcx, ANSWER
    mov     eax, ecx
    add     rsp, 40
    ret
ex_04_include_guard_sim ENDP
main PROC
    sub     rsp, 40
    call    ex_04_include_guard_sim
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
