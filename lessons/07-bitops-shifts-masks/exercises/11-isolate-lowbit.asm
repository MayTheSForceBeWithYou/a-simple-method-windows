; Exercise: 11-isolate-lowbit
;
; Implement the student routine in this file.
;
; Contract: implement `ex_11_isolate_lowbit` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 4
;

; 11-isolate-lowbit.asm
;
; Isolate the lowest set bit using bitwise trick: x & (-x).
;
; Task: Given value 0b11010100 (212), isolate the lowest set bit.
;       The lowest set bit is bit 2 (value 4).
;       Exit with the isolated bit value.
;
; Hint: The expression (x & -x) isolates the lowest set bit.
;       NEG creates two's complement; ANDing with original isolates lowest 1.

.CODE

EXTRN ExitProcess:PROC
EXTRN ex_11_isolate_lowbit:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_11_isolate_lowbit in this file.
    call    ex_11_isolate_lowbit
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
