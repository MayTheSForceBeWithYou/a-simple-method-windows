; Exercise: 13-setb-unsigned
;
; rax=1, rbx=2. cmp; setb al; exit 1 (below unsigned).
;
; Contract: implement `ex_13_setb_unsigned` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 1
;
.CODE

EXTRN ExitProcess:PROC
EXTERNDEF ex_13_setb_unsigned:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_13_setb_unsigned in this file.
    call    ex_13_setb_unsigned
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
