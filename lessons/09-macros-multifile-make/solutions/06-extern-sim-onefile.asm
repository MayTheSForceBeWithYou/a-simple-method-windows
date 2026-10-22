; Exercise: 06-extern-sim-onefile
;
; Simulate two units in one file with helper procedure; exit 5.
; Expected exit: 5
;
.code
ex_06_extern_sim_onefile PROC
    sub rsp, 40
    call helper
    mov rcx, rax
    mov     eax, eax
    add     rsp, 40
    ret
ex_06_extern_sim_onefile ENDP
main PROC
    sub     rsp, 40
    call    ex_06_extern_sim_onefile
    mov     rcx, rax
    call    ExitProcess
main ENDP

helper PROC
    mov rax, 5
    ret
helper ENDP
END
