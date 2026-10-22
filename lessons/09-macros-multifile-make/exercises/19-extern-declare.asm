; Exercise: 19-extern-declare
;
; EXTERN for multi-file; local call exit 9.
;
; Contract: implement `ex_19_extern_declare` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 9
;
.CODE

EXTRN ExitProcess:PROC
EXTRN ex_19_extern_declare:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_19_extern_declare in this file.
    call    ex_19_extern_declare
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
