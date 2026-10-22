; Exercise: 09-cmp-sete
;
; rax=5, rbx=5. cmp; sete al; movzx rcx,al; exit 1.
;
; Contract: implement `ex_09_cmp_sete` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 1
;
.CODE

EXTRN ExitProcess:PROC
EXTRN ex_09_cmp_sete:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_09_cmp_sete in this file.
    call    ex_09_cmp_sete
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
