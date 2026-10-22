; Exercise: 06-eax-zero-extends
;
; Set rax to all 0FFh bytes, then mov eax, 1. Exit with rcx=rax (should be 1).
;
; Contract: implement `ex_06_eax_zero_extends` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 1
;
.CODE

EXTRN ExitProcess:PROC
EXTERNDEF ex_06_eax_zero_extends:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_06_eax_zero_extends in this file.
    call    ex_06_eax_zero_extends
    mov     ecx, eax
    call    ExitProcess
    
main ENDP

END
