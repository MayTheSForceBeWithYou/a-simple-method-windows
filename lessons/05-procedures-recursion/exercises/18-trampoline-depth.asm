; Exercise: 18-trampoline-depth
;
; bump(8) recursive count. Exit 8.
;
; Contract: implement `ex_18_trampoline_depth` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 8
;
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_18_trampoline_depth:PROC



main PROC
    sub     rsp, 40

    ; TODO: write ex_18_trampoline_depth in this file.
    call    ex_18_trampoline_depth
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
