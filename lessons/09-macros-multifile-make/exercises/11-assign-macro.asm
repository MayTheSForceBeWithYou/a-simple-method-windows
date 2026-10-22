; Exercise: 11-assign-macro
;
; Use = (MASM assignment) with REPT loop; exit 4 after 4 incs.
;
; Contract: implement `ex_11_assign_macro` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 4
;
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_11_assign_macro:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_11_assign_macro in this file.
    call    ex_11_assign_macro
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
