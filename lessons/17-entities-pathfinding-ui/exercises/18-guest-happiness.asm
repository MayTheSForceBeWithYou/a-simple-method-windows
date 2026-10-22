; Exercise: 18-guest-happiness
;
; Exercise 18: guest happiness
; Clamp happiness add 20 from 90 -> 100; exit 100.
; Expected stdout: (none)
;
; Contract: implement `ex_18_guest_happiness` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 100
;

; 18-guest-happiness: guest happiness
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_18_guest_happiness:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_18_guest_happiness in this file.
    call    ex_18_guest_happiness
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
