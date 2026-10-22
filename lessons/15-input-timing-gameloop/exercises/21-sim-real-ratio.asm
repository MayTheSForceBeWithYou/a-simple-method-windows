; Exercise: 21-sim-real-ratio
;
; sim_time/real_time *100 = 50 when half speed; exit 50.
; Expected stdout: (none)
;
; Contract: implement `ex_21_sim_real_ratio` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 50
;
.CODE
EXTRN ExitProcess:PROC
EXTERNDEF ex_21_sim_real_ratio:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_21_sim_real_ratio in this file.
    call    ex_21_sim_real_ratio
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
