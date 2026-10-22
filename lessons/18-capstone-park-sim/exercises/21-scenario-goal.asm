; Exercise: 21-scenario-goal
;
; Exercise 21: scenario goal
; Guests>=100 goal; guests=100; exit 1 success.
; Expected stdout: (none)
;
; Contract: implement `ex_21_scenario_goal` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 1
;

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
