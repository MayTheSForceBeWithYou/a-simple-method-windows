; Exercise: 22-stretch-pratt-stub
;
; STRETCH: binding power for + is 10, for * is 20; exit 20.
;
; Contract: implement `ex_22_stretch_pratt_stub` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 20
;
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_22_stretch_pratt_stub:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_22_stretch_pratt_stub in this file.
    call    ex_22_stretch_pratt_stub
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
