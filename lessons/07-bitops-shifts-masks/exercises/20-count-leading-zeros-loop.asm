; 20-count-leading-zeros-loop.asm
;
; Count leading zeros in a 16-bit value using a loop.
;
; Task: Count leading zeros in 00030h (binary 0000000000110000).
;       There are 10 leading zeros. Exit with the count.
;
; Hint: Loop up to 16 times, checking bit 15 each iteration.
;       If bit 15 is 0, increment counter and shift left.
;       If bit 15 is 1, stop.

.CODE

EXTRN ExitProcess:PROC
EXTRN ex_20_count_leading_zeros_loop:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_20_count_leading_zeros_loop in this file.
    call    ex_20_count_leading_zeros_loop
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
