; Exercise: 10-bit-set-clear
;
; Set bit 3, then clear it; exit 0.
;
; Contract: implement `ex_10_bit_set_clear` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 0
;
.CODE

EXTRN ExitProcess:PROC
EXTERNDEF ex_10_bit_set_clear:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_10_bit_set_clear in this file.
    call    ex_10_bit_set_clear
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
