; Exercise: 11-test-zf
;
; rax=0; test rax,rax; sete al; exit 1.
;
; Contract: implement `ex_11_test_zf` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 1
;
.CODE

EXTRN ExitProcess:PROC
EXTRN ex_11_test_zf:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_11_test_zf in this file.
    call    ex_11_test_zf
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
