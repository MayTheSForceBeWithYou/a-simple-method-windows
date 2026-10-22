; 07-emit-syscall-exit.asm: Emit exit syscall sequence, exit 0
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_07_emit_syscall_exit:PROC
main PROC
    ; TODO: implement ex_07_emit_syscall_exit (student routine; defined in solutions/).
    call    ex_07_emit_syscall_exit
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
