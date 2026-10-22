; Exercise: 06-ride-open
;
; Exercise 06: ride open
; flag open=1; exit 1.
; Expected stdout: (none)
;
; Contract: implement `ex_06_ride_open` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 1
;

; 06-ride-open: ride open
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_06_ride_open:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_06_ride_open in this file.
    call    ex_06_ride_open
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
