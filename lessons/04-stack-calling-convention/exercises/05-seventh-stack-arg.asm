; Exercise: 05-seventh-stack-arg
;
; sum7 uses 7th arg on stack. Pass 1..7; exit 28.
;
; Contract: implement `ex_05_seventh_stack_arg` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 28
;
.CODE

EXTRN ExitProcess:PROC
EXTRN ex_05_seventh_stack_arg:PROC

; TODO: write ex_05_seventh_stack_arg in this file.

main PROC
    sub     rsp, 40
    call    ex_05_seventh_stack_arg
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
