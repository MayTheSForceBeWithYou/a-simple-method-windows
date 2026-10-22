; 04-agent-step: agent step
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_04_agent_step:PROC
main PROC
    ; TODO: write ex_04_agent_step in this file.
    call    ex_04_agent_step
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
