; Exercise: 02-je-equal
;
; rax=3,rbx=3. If equal exit 1 else 0.
;
; Contract: implement `ex_02_je_equal` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 1
;
.CODE

EXTRN ExitProcess:PROC
EXTERNDEF ex_02_je_equal:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_02_je_equal in this file.
    call    ex_02_je_equal
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
