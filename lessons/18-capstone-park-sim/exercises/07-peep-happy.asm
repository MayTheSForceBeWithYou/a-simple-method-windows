; Exercise: 07-peep-happy
;
; happiness clamp 0..100; set 120->100.
; Expected stdout: (none)
;
; Contract: implement `ex_07_peep_happy` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 100
;
.CODE
EXTRN ExitProcess:PROC
EXTERNDEF ex_07_peep_happy:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_07_peep_happy in this file.
    call    ex_07_peep_happy
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
