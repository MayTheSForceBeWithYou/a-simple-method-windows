; Exercise: 17-while-codegen
;
; while i<3 i++; exit i=3.
;
; Contract: implement `ex_17_while_codegen` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 3
;
.CODE
EXTRN ExitProcess:PROC
EXTERNDEF ex_17_while_codegen:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_17_while_codegen in this file.
    call    ex_17_while_codegen
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
