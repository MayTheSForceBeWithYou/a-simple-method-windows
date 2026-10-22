; Exercise: 18-mask-range
;
; Implement the student routine in this file.
;
; Contract: implement `ex_18_mask_range` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 31
;

; 18-mask-range.asm
;
; Create a mask for a range of bits.
;
; Task: Generate a mask with bits 2-5 set (value 0b00111100 = 03Ch = 60).
;       Exit with the mask.
;
; Hint: One method:
;       - Create mask with N bits set: (1 << N) - 1
;       - Shift it left to position
;       Example: (1 << 4) - 1 = 15 (bits 0-3), shift left by 2 → 60 (bits 2-5)

.CODE

EXTRN ExitProcess:PROC
EXTRN ex_18_mask_range:PROC

main PROC
    sub     rsp, 40
    ; TODO: Compute mask with bits 2-5 set
    
    ; TODO: write ex_18_mask_range in this file.
    call    ex_18_mask_range
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
