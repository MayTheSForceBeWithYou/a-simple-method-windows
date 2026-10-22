; Exercise: 13-align-before-call
;
; Stack alignment check. MS x64 requires 16-byte alignment before call.
;
; Contract: implement `ex_13_align_before_call` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 0
;
.CODE

EXTRN ExitProcess:PROC
EXTRN ex_13_align_before_call:PROC

; TODO: write ex_13_align_before_call in this file.

main PROC
    sub     rsp, 40
    call    ex_13_align_before_call
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
