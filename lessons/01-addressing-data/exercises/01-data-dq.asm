; Exercise: 01-data-dq
;
; Define count QWORD 41 in .data. Load into rcx, add 1, exit (42).
;
; Contract: implement `ex_01_data_dq` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 42
;
.CODE

EXTRN ExitProcess:PROC
EXTERNDEF ex_01_data_dq:PROC

main PROC
    sub     rsp, 40
    ; TODO: Load count into RAX, add 1, move to RCX, exit
    ; TODO: write ex_01_data_dq in this file.
    call    ex_01_data_dq
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
