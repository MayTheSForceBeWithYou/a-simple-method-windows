; Exercise: 03-add-two-args
;
; Function add(rcx,rdx)->rax. Call with 10,32; exit 42.
;
; Contract: implement `ex_03_add_two_args` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 42
;
; Implement `add2(rcx, rdx)` returning sum in RAX. In `ex_03_add_two_args`, call `add2(10, 32)` and exit with the result (42).
;
.CODE

EXTRN ExitProcess:PROC
EXTERNDEF ex_03_add_two_args:PROC

; TODO: write ex_03_add_two_args in this file.

main PROC
    sub     rsp, 40
    call    ex_03_add_two_args
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
