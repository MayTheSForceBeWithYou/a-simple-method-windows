; Exercise: 16-if-codegen
;
; if 1 then 7 else 9; exit 7.
;
; Contract: implement `ex_16_if_codegen` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 7
;
.CODE
EXTRN ExitProcess:PROC
EXTERNDEF ex_16_if_codegen:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_16_if_codegen in this file.
    call    ex_16_if_codegen
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
