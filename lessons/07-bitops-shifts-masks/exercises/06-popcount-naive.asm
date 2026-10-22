; Exercise: 06-popcount-naive
;
; Exercise 06: popcount naive
; Popcount of 0b101101 = 4.
;
; Contract: implement `ex_06_popcount_naive` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 4
;

; 06-popcount-naive.asm
;
; Implement popcount (count set bits) using a loop.
;
; Task: Count the number of 1 bits in the value 0b10110111 (decimal 183).
;       The value has 6 set bits. Exit with the count.
;
; Hint: Use a loop that:
;       - Checks if bit 0 is set with TEST reg, 1
;       - Increments a counter if set
;       - Shifts right by 1
;       - Repeats until the value is zero

.CODE

EXTRN ExitProcess:PROC
EXTRN ex_06_popcount_naive:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_06_popcount_naive in this file.
    call    ex_06_popcount_naive
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
