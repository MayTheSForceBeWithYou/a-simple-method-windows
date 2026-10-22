; Exercise: 07-stack-ds
;
; Push 1,2 pop to rdi; exit 2.
;
; Push 1,2 pop into RCX; exit 2.
;
; Contract: implement `ex_07_stack_ds` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 2
;
.CODE
EXTRN ExitProcess:PROC
EXTERNDEF ex_07_stack_ds:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_07_stack_ds in this file.
    call    ex_07_stack_ds
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
