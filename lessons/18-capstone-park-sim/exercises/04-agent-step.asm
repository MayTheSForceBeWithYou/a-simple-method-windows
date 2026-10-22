; Exercise: 04-agent-step
;
; agent x++; exit x.
; Expected stdout: (none)
;
; Contract: implement `ex_04_agent_step` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 1
;
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_04_agent_step:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_04_agent_step in this file.
    call    ex_04_agent_step
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
