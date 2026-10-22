; Exercise: 21-scenario-goal
;
; Guests>=100 goal; guests=100; exit 1 success.
; Expected stdout: (none)
; Expected exit: 1
;
.data
guests QWORD 0

.code
ex_21_scenario_goal PROC
    sub rsp, 40
    mov QWORD PTR [guests], 100
    cmp QWORD PTR [guests], 100
    jl goal_no
    mov rcx, 1
    jmp goal_done
goal_no:
    xor ecx, ecx
goal_done:
    mov     eax, ecx
    add     rsp, 40
    ret
ex_21_scenario_goal ENDP
main PROC
    sub     rsp, 40
    call    ex_21_scenario_goal
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
