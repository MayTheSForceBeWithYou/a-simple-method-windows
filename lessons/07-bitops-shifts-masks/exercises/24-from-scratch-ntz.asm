; Exercise: 24-from-scratch-ntz
;
; Number of trailing zeros in 0b1011000 = 3.
;
; Contract: implement `ex_24_from_scratch_ntz` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 3
;
.CODE

EXTRN ExitProcess:PROC
EXTRN ex_24_from_scratch_ntz:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_24_from_scratch_ntz in this file.
    call    ex_24_from_scratch_ntz
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
