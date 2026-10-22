; Exercise 15: getpid
;
; Call GetCurrentProcessId. Exit 0 if the PID is nonzero, else 1.
;
; Contract: implement `ex_15_getpid`; return exit code in EAX.
; Expected exit: 0

.CODE

EXTRN GetCurrentProcessId:PROC
EXTRN ExitProcess:PROC
EXTRN ex_15_getpid:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_15_getpid in this file.
    call    ex_15_getpid
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
