; Exercise: 01-unconditional-jmp
;
; jmp over a mov rcx,99; fallthrough sets rcx=7; exit 7.
;
; Contract: implement `ex_01_unconditional_jmp` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 7
;
.CODE

EXTRN ExitProcess:PROC
EXTRN ex_01_unconditional_jmp:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_01_unconditional_jmp in this file.
    call    ex_01_unconditional_jmp
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
