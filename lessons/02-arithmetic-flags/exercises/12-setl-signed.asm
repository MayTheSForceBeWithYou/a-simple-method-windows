; Exercise: 12-setl-signed
;
; rax=-1 (or 0FFFFFFFFFFFFFFFFh), rbx=0. cmp rax,rbx; setl al; exit 1.
;
; Contract: implement `ex_12_setl_signed` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 1
;
.CODE

EXTRN ExitProcess:PROC
EXTERNDEF ex_12_setl_signed:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_12_setl_signed in this file.
    call    ex_12_setl_signed
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
