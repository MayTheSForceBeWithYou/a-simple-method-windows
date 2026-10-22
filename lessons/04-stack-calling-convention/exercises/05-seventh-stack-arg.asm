; Exercise: 05-seventh-stack-arg
;
; sum7 uses 7th arg on stack. Pass 1..7; exit 28.
;
; Contract: implement `ex_05_seventh_stack_arg` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 28
;
; Implement `sum7(a..g)`: RCX,RDX,R8,R9 plus stack args at caller [rsp+32],[rsp+40],[rsp+48] (callee sees them at [rsp+40],[rsp+48],[rsp+56] after the call). In `ex_05_seventh_stack_arg`, pass 1..7 and exit 28. Main uses `sub rsp,40`; student setup may use `sub rsp,56` before `call sum7`.
;
.CODE

EXTRN ExitProcess:PROC
EXTERNDEF ex_05_seventh_stack_arg:PROC

; TODO: write ex_05_seventh_stack_arg in this file.

main PROC
    sub     rsp, 40
    call    ex_05_seventh_stack_arg
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
