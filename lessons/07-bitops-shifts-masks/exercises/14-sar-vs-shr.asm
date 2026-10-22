; 14-sar-vs-shr.asm
;
; Demonstrate the difference between SAR and SHR on a negative value.
;
; Task: Load -32 into AL (as signed 8-bit: 0E0h = -32).
;       Use SHR to divide by 4 (shift right by 2).
;       Exit with the result to see the incorrect unsigned result.
;
; Then compare: if you used SAR instead, you'd get -8 (0F8h = 248).
;
; Hint: SHR on -32 (0E0h) shifts right filling with 0, giving 038h = 56.
;       SAR on -32 (0E0h) shifts right preserving sign, giving 0F8h = 248.

.CODE

EXTRN ExitProcess:PROC
EXTRN ex_14_sar_vs_shr:PROC

main PROC
    sub     rsp, 40
    ; TODO: implement ex_14_sar_vs_shr (student routine; defined in solutions/).
    call    ex_14_sar_vs_shr
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
