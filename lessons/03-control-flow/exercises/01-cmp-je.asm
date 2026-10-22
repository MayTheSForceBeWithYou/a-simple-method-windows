; Exercise: 01-cmp-je
;
; Implement `ex_01_cmp_je` in this file.
;
; Contract: implement `ex_01_cmp_je` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 1
;
.CODE

EXTRN ExitProcess:PROC
EXTERNDEF ex_01_cmp_je:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_01_cmp_je in this file.
    call    ex_01_cmp_je
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
