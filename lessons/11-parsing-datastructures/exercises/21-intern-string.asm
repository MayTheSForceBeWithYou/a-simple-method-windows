; Exercise: 21-intern-string
;
; Intern table pointer equality: same slot; exit 1.
;
; Contract: implement `ex_21_intern_string` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 1
;
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_21_intern_string:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_21_intern_string in this file.
    call    ex_21_intern_string
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
