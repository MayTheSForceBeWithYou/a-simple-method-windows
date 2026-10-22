; Exercise: 14-print-A
;
; Write "A\n". Exit 0.
;
; Contract: implement `ex_14_print_A` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 0
;
.CODE

EXTRN ExitProcess:PROC
EXTRN ex_14_print_A:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_14_print_A in this file.
    call    ex_14_print_A
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
