; Exercise: 21-min-via-cmovl
;
; Same with 17 and 23; min into rcx (17) using cmovl.
;
; Contract: implement `ex_21_min_via_cmovl` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 17
;
.CODE

EXTRN ExitProcess:PROC
EXTERNDEF ex_21_min_via_cmovl:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_21_min_via_cmovl in this file.
    call    ex_21_min_via_cmovl
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
