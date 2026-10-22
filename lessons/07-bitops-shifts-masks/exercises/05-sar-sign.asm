; Exercise: 05-sar-sign
;
; Implement the student routine in this file.
;
; Contract: implement `ex_05_sar_sign` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 252
;

; 05-sar-sign.asm
;
; Use SAR (shift arithmetic right) to divide a signed negative number.
;
; Task: Load -16 into RAX, then use SAR to divide by 4 (shift right by 2).
;       Exit with the result (should be -4, which is 252 as an 8-bit unsigned).
;
; Hint: SAR preserves the sign bit, correctly dividing signed values.
;       Use SAR, not SHR, for signed division.

.CODE

EXTRN ExitProcess:PROC
EXTRN ex_05_sar_sign:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_05_sar_sign in this file.
    call    ex_05_sar_sign
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
