; Exercise: 16-mov-imm-vs-reg
;
; Load 100 into rax (imm), copy to rbx, copy rbx to rcx, exit.
;
; Contract: implement `ex_16_mov_imm_vs_reg` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 100
;
.CODE

EXTRN ExitProcess:PROC
EXTRN ex_16_mov_imm_vs_reg:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_16_mov_imm_vs_reg in this file.
    call    ex_16_mov_imm_vs_reg
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
