; Exercise: 04-codegen-add
;
; Fold 2+3 at compile-time; exit 5.
;
; Contract: implement `ex_04_codegen_add` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 5
;
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_04_codegen_add:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_04_codegen_add in this file.
    call    ex_04_codegen_add
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
