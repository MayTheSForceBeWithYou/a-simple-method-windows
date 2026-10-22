; Exercise: 01-and-mask
;
; Implement `ex_01_and_mask` in this file.
;
; Contract: implement `ex_01_and_mask` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 15
;
.CODE

EXTRN ExitProcess:PROC
EXTERNDEF ex_01_and_mask:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_01_and_mask in this file.
    call    ex_01_and_mask
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
