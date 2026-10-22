; Exercise: 20-label-addresses
;
; Two messages; print only msg2 "use me\n". Exit 0.
;
; Contract: implement `ex_20_label_addresses` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 0
;
.CODE

EXTRN ExitProcess:PROC
EXTERNDEF ex_20_label_addresses:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_20_label_addresses in this file.
    call    ex_20_label_addresses
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
