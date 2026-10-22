; Exercise: 28-from-scratch-echo-lit
;
; FROM SCRATCH: Print "masm+link\n" and exit 0.
;
; Contract: implement `ex_28_from_scratch_echo_lit` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 0
;
.CODE

EXTRN ExitProcess:PROC
EXTERNDEF ex_28_from_scratch_echo_lit:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_28_from_scratch_echo_lit in this file.
    call    ex_28_from_scratch_echo_lit
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
