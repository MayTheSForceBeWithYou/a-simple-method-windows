; Exercise: 04-count-loop
;
; Implement `ex_04_count_loop` in this file.
;
; Contract: implement `ex_04_count_loop` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 5
;
.CODE

EXTRN ExitProcess:PROC
EXTERNDEF ex_04_count_loop:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_04_count_loop in this file.
    call    ex_04_count_loop
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
