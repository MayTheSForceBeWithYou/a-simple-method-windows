; Exercise: 21-abi-quiz-exit
;
; MS x64: args in rcx,rdx,r8,r9. identity4 returns arg4 (r9). Exit 4.
; Expected stdout: (none)
;
; Contract: implement `ex_21_abi_quiz_exit` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 4
;
.CODE

EXTRN ExitProcess:PROC
EXTERNDEF ex_21_abi_quiz_exit:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_21_abi_quiz_exit in this file.
    call    ex_21_abi_quiz_exit
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
