; Exercise: 05-counted-loop
;
; Add r8 times: start rcx=0,r8=5; loop add 3 each time; exit 15.
;
; Contract: implement `ex_05_counted_loop` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 15
;
.CODE

EXTRN ExitProcess:PROC
EXTERNDEF ex_05_counted_loop:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_05_counted_loop in this file.
    call    ex_05_counted_loop
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
