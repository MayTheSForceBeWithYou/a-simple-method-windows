; 02-or-flags.asm
;
; Use OR to set specific bits (set flags).
;
; Task: Start with RAX = 0.
;       Use OR to set bit 0, then OR again to set bit 3.
;       Exit with the result (should be 0b1001 = 9).
;
; Hint: To set bit N, OR with (1 << N).
;       Bit 0 is 1, bit 3 is 8.

.CODE

EXTRN ExitProcess:PROC
EXTRN ex_02_or_flags:PROC

main PROC
    sub     rsp, 40
    ; TODO: implement ex_02_or_flags (student routine; defined in solutions/).
    call    ex_02_or_flags
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
