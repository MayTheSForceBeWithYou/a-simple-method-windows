; Exercise: 03-neg
;
; mov rcx, 5; neg rcx; add rcx, 10; exit (5).
;
; Contract: implement `ex_03_neg` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 5
;
.CODE

EXTRN ExitProcess:PROC
EXTERNDEF ex_03_neg:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_03_neg in this file.
    call    ex_03_neg
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
