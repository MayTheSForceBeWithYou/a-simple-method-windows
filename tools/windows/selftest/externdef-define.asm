; Harness self-test: EXTERNDEF plus in-file definition must assemble, link, and run.
; Expected exit: 0

EXTERN ExitProcess:PROC
EXTERNDEF ex_t:PROC

.CODE
ex_t PROC
    mov     eax, 0
    ret
ex_t ENDP

main PROC
    sub     rsp, 40
    call    ex_t
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
