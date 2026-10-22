; 13-shl-shl-combine.asm
;
; Combine two values into one register using shifts.
;
; Task: Put value 012h in the high byte (bits 8-15) and 034h in the low byte
;       (bits 0-7) of a 16-bit value.
;       Exit with the combined value (should be 01234h = 4660).
;
; Hint: Shift the high byte left by 8, OR it with the low byte.

.CODE

EXTRN ExitProcess:PROC
EXTRN ex_13_shl_shl_combine:PROC

main PROC
    sub     rsp, 40
    ; TODO: implement ex_13_shl_shl_combine (student routine; defined in solutions/).
    call    ex_13_shl_shl_combine
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
