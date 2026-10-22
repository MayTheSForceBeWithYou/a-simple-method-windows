; Exercise: 30-signed-vs-unsigned-jmp
;
; rax=0FFFFFFFFFFFFFFFFh (-1 signed), cmp to 1. Using jl should take less path exit 1; document why ja would not.
;
; Contract: implement `ex_30_signed_vs_unsigned_jmp` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 1
;
.CODE

EXTRN ExitProcess:PROC
EXTRN ex_30_signed_vs_unsigned_jmp:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_30_signed_vs_unsigned_jmp in this file.
    call    ex_30_signed_vs_unsigned_jmp
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
