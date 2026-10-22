; Exercise: 11-isolate-lowbit
;
; Implement `ex_11_isolate_lowbit` in this file.
;
; Contract: implement `ex_11_isolate_lowbit` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 4
;
.CODE

EXTRN ExitProcess:PROC
EXTRN ex_11_isolate_lowbit:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_11_isolate_lowbit in this file.
    call    ex_11_isolate_lowbit
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
