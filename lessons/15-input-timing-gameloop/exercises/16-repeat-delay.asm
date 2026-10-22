; Exercise: 16-repeat-delay
;
; Exercise 16: repeat delay
; Key repeat after 3 ticks; tick count 3 -> fire; exit 1.
; Expected stdout: (none)
;
; Contract: implement `ex_16_repeat_delay` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 1
;

; 16-repeat-delay: repeat delay
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_16_repeat_delay:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_16_repeat_delay in this file.
    call    ex_16_repeat_delay
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
