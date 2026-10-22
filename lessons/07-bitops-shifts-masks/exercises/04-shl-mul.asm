; Exercise: 04-shl-mul
;
; Implement the student routine in this file.
;
; Contract: implement `ex_04_shl_mul` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 24
;

; 04-shl-mul.asm
;
; Use SHL (shift left) to multiply by a power of 2.
;
; Task: Load 7 into RAX, then use SHL to multiply by 8 (2^3).
;       Exit with the result (should be 56).
;
; Hint: Shifting left by N multiplies by 2^N.
;       To multiply by 8, shift left by 3.

.CODE

EXTRN ExitProcess:PROC
EXTRN ex_04_shl_mul:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_04_shl_mul in this file.
    call    ex_04_shl_mul
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
