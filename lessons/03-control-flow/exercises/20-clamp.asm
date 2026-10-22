; Exercise: 20-clamp
;
; x=150. Clamp to [0,100]. Exit 100.
;
; Contract: implement `ex_20_clamp` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 100
;
.CODE

EXTRN ExitProcess:PROC
EXTERNDEF ex_20_clamp:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_20_clamp in this file.
    call    ex_20_clamp
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
