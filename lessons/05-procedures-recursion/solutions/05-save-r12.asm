; Exercise 05: save r12
; Use r12 in callee; must push/pop. r12=42 preserved. Exit 42.
; Expected exit: 42

EXTERN ExitProcess:PROC

.code
main PROC
    sub rsp, 32
    mov r12, 42
    call use_r12
    mov rcx, r12
    call ExitProcess
main ENDP

use_r12 PROC
    push r12
    mov r12, 0
    pop r12
    ret
use_r12 ENDP
END
