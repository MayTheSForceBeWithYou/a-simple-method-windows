; Exercise: 18-strlen-loop
;
; Cstring 'hello',0. Count length 5 into rcx.
;
; Contract: implement `ex_18_strlen_loop` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 5
;
.CODE

EXTRN ExitProcess:PROC
EXTERNDEF ex_18_strlen_loop:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_18_strlen_loop in this file.
    call    ex_18_strlen_loop
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
