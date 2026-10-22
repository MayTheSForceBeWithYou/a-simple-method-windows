; Exercise: 17-imul-neg
;
; rax=-3; imul rax, -4; mov rcx,rax; exit 12.
;
; Contract: implement `ex_17_imul_neg` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 12
;
.CODE

EXTRN ExitProcess:PROC
EXTRN ex_17_imul_neg:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_17_imul_neg in this file.
    call    ex_17_imul_neg
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
