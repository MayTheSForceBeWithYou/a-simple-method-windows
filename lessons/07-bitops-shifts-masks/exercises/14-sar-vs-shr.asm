; Exercise: 14-sar-vs-shr
;
; Exercise 14: sar vs shr
; For -4: sar 1 vs shr 1; exit (sar_result == -2) as 1.
;
; Contract: implement `ex_14_sar_vs_shr` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 1
;

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
    ; TODO: write ex_14_sar_vs_shr in this file.
    call    ex_14_sar_vs_shr
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
