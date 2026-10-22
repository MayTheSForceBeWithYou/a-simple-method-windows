; Exercise: 16-bss-resq
;
; QWORD ? DUP(4). Store 1,2,3,4 into consecutive qwords; sum into rcx (10); exit.
;
; Contract: implement `ex_16_bss_resq` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 10
;
.CODE

EXTRN ExitProcess:PROC
EXTERNDEF ex_16_bss_resq:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_16_bss_resq in this file.
    call    ex_16_bss_resq
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
