; Exercise: 29-from-scratch-factorial-loop
;
; FROM SCRATCH: 6! with a counted loop = 720. Exit 720&255=208.
;
; Contract: implement `ex_29_from_scratch_factorial_loop` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 208
;
.CODE

EXTRN ExitProcess:PROC
EXTERNDEF ex_29_from_scratch_factorial_loop:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_29_from_scratch_factorial_loop in this file.
    call    ex_29_from_scratch_factorial_loop
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
