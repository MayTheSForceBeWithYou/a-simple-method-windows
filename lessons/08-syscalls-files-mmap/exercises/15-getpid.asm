; Exercise: 15-getpid
;
; GetCurrentProcessId; exit 0 if the pid is nonzero, else 1.
;
; Contract: implement `ex_15_getpid` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 0
;
.CODE

EXTRN GetCurrentProcessId:PROC
EXTRN ExitProcess:PROC
EXTERNDEF ex_15_getpid:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_15_getpid in this file.
    call    ex_15_getpid
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
