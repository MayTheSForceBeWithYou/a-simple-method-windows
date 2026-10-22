; Exercise: 16-clamp-q
;
; Clamp -3 to [0,100]; exit 0.
;
; Contract: implement `ex_16_clamp_q` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 0
;
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_16_clamp_q:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_16_clamp_q in this file.
    call    ex_16_clamp_q
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
