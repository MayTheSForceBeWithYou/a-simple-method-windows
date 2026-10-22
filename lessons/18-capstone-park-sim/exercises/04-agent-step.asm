; 04-agent-step: agent step
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_04_agent_step:PROC
main PROC
    ; TODO: implement ex_04_agent_step (student routine; defined in solutions/).
    call    ex_04_agent_step
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
