; Exercise: 05-imul-three
;
; Set rcx=6 then imul rcx,7. Exit 42.
;
; Contract: implement `ex_05_imul_three` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 42
;
.CODE

EXTRN ExitProcess:PROC
EXTERNDEF ex_05_imul_three:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_05_imul_three in this file.
    call    ex_05_imul_three
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
