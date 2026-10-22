; Exercise: 28-from-scratch-swap
;
; FROM SCRATCH: a QWORD 1 / b QWORD 2. Swap via registers; exit with rcx=a (should be 2).
;
; Contract: implement `ex_28_from_scratch_swap` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 2
;
.CODE

EXTRN ExitProcess:PROC
EXTERNDEF ex_28_from_scratch_swap:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_28_from_scratch_swap in this file.
    call    ex_28_from_scratch_swap
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
