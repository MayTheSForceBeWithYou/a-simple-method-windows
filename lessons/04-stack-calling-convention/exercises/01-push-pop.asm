; Exercise: 01-push-pop
;
; push 3; push 4; pop rax; pop rcx; add rcx,rax; exit 7.
;
; Contract: implement `ex_01_push_pop` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 7
;
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_01_push_pop:PROC

main PROC
    sub     rsp, 40
    ; TODO: PUSH 42, PUSH 99, POP to RBX, POP to RCX, exit with RCX
    ; TODO: write ex_01_push_pop in this file.
    call    ex_01_push_pop
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
