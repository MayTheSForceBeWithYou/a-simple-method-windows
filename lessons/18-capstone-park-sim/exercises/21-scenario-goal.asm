; 21-scenario-goal: scenario goal
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_21_scenario_goal:PROC
main PROC
    ; TODO: implement ex_21_scenario_goal (student routine; defined in solutions/).
    call    ex_21_scenario_goal
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
