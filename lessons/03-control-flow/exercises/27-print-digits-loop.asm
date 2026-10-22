; Exercise: 27-print-digits-loop
;
; Print "01234\n" using a loop that stores digits into a buffer then one write. Exit 0.
;
; Contract: implement `ex_27_print_digits_loop` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 0
;
.CODE

EXTRN ExitProcess:PROC
EXTRN ex_27_print_digits_loop:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_27_print_digits_loop in this file.
    call    ex_27_print_digits_loop
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
