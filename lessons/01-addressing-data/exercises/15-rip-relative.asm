; Exercise: 15-rip-relative
;
; Use lea rdx,[msg] (RIP-relative by default in MASM x64) to write msg 'rip\n'. Exit 0.
;
; Contract: implement `ex_15_rip_relative` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 0
;
.CODE

EXTRN ExitProcess:PROC
EXTRN ex_15_rip_relative:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_15_rip_relative in this file.
    call    ex_15_rip_relative
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
