; Exercise: 03-xor-swap
;
; Implement the student routine in this file.
;
; Contract: implement `ex_03_xor_swap` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 2
;

; 03-xor-swap.asm
;
; Swap two registers using the XOR swap algorithm.
;
; Task: Start with RAX = 10, RBX = 20.
;       Use three XOR operations to swap them.
;       Exit with RAX (should be 20 after swap).
;
; Hint: The XOR swap pattern is:
;       xor a, b
;       xor b, a
;       xor a, b

.CODE

EXTRN ExitProcess:PROC
EXTRN ex_03_xor_swap:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_03_xor_swap in this file.
    call    ex_03_xor_swap
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
