; Exercise: 21-sim-real-ratio
;
; sim_time/real_time *100 = 50 when half speed; exit 50.
; Expected stdout: (none)
; Expected exit: 50
;
.code
ex_21_sim_real_ratio PROC
    sub rsp, 40
    mov rcx, 50
    mov     eax, 50
    add     rsp, 40
    ret
ex_21_sim_real_ratio ENDP
main PROC
    sub     rsp, 40
    call    ex_21_sim_real_ratio
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
