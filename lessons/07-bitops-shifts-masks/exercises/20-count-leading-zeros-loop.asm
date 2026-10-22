; Exercise: 20-count-leading-zeros-loop
;
; Count leading zeros in 000F0h (16-bit) -> 8.
;
; Contract: implement `ex_20_count_leading_zeros_loop` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 8
;
.CODE

EXTRN ExitProcess:PROC
EXTERNDEF ex_20_count_leading_zeros_loop:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_20_count_leading_zeros_loop in this file.
    call    ex_20_count_leading_zeros_loop
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
