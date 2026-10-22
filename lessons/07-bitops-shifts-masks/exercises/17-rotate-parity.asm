; Exercise: 17-rotate-parity
;
; Implement `ex_17_rotate_parity` in this file.
;
; Contract: implement `ex_17_rotate_parity` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 128
;
.CODE

EXTRN ExitProcess:PROC
EXTRN ex_17_rotate_parity:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_17_rotate_parity in this file.
    call    ex_17_rotate_parity
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
