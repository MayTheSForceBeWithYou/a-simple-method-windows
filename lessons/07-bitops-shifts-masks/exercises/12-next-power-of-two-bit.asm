; Exercise: 12-next-power-of-two-bit
;
; Test if 16 is power of two; exit 1.
;
; Contract: implement `ex_12_next_power_of_two_bit` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 1
;
.CODE

EXTRN ExitProcess:PROC
EXTRN ex_12_next_power_of_two_bit:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_12_next_power_of_two_bit in this file.
    call    ex_12_next_power_of_two_bit
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
