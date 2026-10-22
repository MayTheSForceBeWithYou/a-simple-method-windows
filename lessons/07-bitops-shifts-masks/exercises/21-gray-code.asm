; 21-gray-code.asm
;
; Convert binary to Gray code using XOR and shift.
;
; Task: Convert binary value 12 (0b1100) to Gray code.
;       Gray code formula: gray = binary ^ (binary >> 1).
;       Exit with Gray code result (should be 10 = 0b1010).
;
; Hint: Copy value to another register, shift right by 1, XOR with original.

.CODE

EXTRN ExitProcess:PROC
EXTRN ex_21_gray_code:PROC

main PROC
    sub     rsp, 40
    ; TODO: implement ex_21_gray_code (student routine; defined in solutions/).
    call    ex_21_gray_code
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
