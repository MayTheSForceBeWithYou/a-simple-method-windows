; Exercise: 21-stretch-banner
;
; STRETCH: Print a 3-line ASCII banner, exit 0.
;
; Contract: implement `ex_21_stretch_banner` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 0
;
.CODE

EXTRN ExitProcess:PROC
EXTERNDEF ex_21_stretch_banner:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_21_stretch_banner in this file.
    call    ex_21_stretch_banner
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
