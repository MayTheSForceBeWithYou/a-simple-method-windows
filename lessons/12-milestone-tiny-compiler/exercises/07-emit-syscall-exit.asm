; Exercise: 07-emit-syscall-exit
;
; Hand-written 'codegen' template exits status 0.
;
; Contract: implement `ex_07_emit_syscall_exit` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 0
;
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_07_emit_syscall_exit:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_07_emit_syscall_exit in this file.
    call    ex_07_emit_syscall_exit
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
