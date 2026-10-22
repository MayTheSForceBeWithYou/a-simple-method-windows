; 21-scenario-goal: scenario goal
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_21_scenario_goal:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_21_scenario_goal in this file.
    call    ex_21_scenario_goal
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
