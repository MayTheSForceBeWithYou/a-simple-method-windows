; Exercise: 25-stretch-call-depth
;
; STRETCH: bump(rcx) calls itself depth times adding 1 each return. bump(5) returns 5.
; Expected stdout: (none)
;
; Contract: implement `ex_25_stretch_call_depth` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 5
;
.CODE

EXTRN ExitProcess:PROC
EXTERNDEF ex_25_stretch_call_depth:PROC

; TODO: write ex_25_stretch_call_depth in this file.

main PROC
    sub     rsp, 40
    call    ex_25_stretch_call_depth
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
