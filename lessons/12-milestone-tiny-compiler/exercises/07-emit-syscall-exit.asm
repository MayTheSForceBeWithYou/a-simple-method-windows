; 07-emit-syscall-exit.asm: Emit exit syscall sequence, exit 0
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
