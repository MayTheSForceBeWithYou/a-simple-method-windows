; Exercise: 07-repeat-macro
;
; REPT 3 increment; exit 3.
;
; Contract: implement `ex_07_repeat_macro` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 3
;
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_07_repeat_macro:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_07_repeat_macro in this file.
    call    ex_07_repeat_macro
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
