; Exercise: 03-sse-add-scalar
;
; Use addss if available — fallback integer exit 5 as stub if we keep pure GP: exit 5.
;
; Contract: implement `ex_03_sse_add_scalar` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 5
;
.CODE
EXTRN ExitProcess:PROC
EXTERNDEF ex_03_sse_add_scalar:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_03_sse_add_scalar in this file.
    call    ex_03_sse_add_scalar
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
