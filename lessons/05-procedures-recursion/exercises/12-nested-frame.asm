; Exercise: 12-nested-frame
;
; outer calls inner. inner returns rcx+rdx. outer adds 1. outer(10,20)=31.
;
; Contract: implement `ex_12_nested_frame` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 31
;
.CODE

EXTRN ExitProcess:PROC
EXTERNDEF ex_12_nested_frame:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_12_nested_frame in this file.
    call    ex_12_nested_frame
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
