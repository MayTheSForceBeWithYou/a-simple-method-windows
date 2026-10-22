; Exercise: 05-signed-cmp
;
; Implement `ex_05_signed_cmp` in this file.
;
; Contract: implement `ex_05_signed_cmp` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 1
;
.CODE

EXTRN ExitProcess:PROC
EXTRN ex_05_signed_cmp:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_05_signed_cmp in this file.
    call    ex_05_signed_cmp
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
