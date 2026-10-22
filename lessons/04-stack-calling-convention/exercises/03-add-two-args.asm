; Exercise: 03-add-two-args
;
; Function add(rcx,rdx)->rax. Call with 10,32; exit 42.
;
; Contract: implement `ex_03_add_two_args` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 42
;
.CODE

EXTRN ExitProcess:PROC
EXTRN ex_03_add_two_args:PROC

; TODO: write ex_03_add_two_args in this file.

main PROC
    sub     rsp, 40
    call    ex_03_add_two_args
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
