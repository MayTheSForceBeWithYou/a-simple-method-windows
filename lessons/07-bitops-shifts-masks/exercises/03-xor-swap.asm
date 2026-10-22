; Exercise: 03-xor-swap
;
; Implement `ex_03_xor_swap` in this file.
;
; Contract: implement `ex_03_xor_swap` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 2
;
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
