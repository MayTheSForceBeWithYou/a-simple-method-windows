; Exercise: 28-from-scratch-abi-add
;
; Exercise 28: from scratch abi add
; FROM SCRATCH: add3(a,b,c) = a+b+c with MS x64 regs; exit 42 for 10,20,12.
;
; Contract: implement `ex_28_from_scratch_abi_add` (MS x64). Return exit code in EAX.
; Expected exit: 42
;

.CODE

EXTRN ExitProcess:PROC
EXTRN ex_28_from_scratch_abi_add:PROC

; TODO: write ex_28_from_scratch_abi_add in this file.

main PROC
    sub     rsp, 40
    call    ex_28_from_scratch_abi_add
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
