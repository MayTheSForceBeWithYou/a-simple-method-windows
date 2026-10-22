; Exercise: 04-imul-two
;
; imul-style: rax=6, imul rax,7; mov rcx,rax; exit 42.
;
; Contract: implement `ex_04_imul_two` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 42
;
.CODE

EXTRN ExitProcess:PROC
EXTRN ex_04_imul_two:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_04_imul_two in this file.
    call    ex_04_imul_two
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
