; Exercise: 04-shl-mul
;
; Implement `ex_04_shl_mul` in this file.
;
; Contract: implement `ex_04_shl_mul` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 24
;
.CODE

EXTRN ExitProcess:PROC
EXTRN ex_04_shl_mul:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_04_shl_mul in this file.
    call    ex_04_shl_mul
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
