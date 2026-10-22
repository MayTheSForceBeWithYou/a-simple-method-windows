; Exercise: 08-lea-scale
;
; Without memory load: rbx=100, r8=3. lea rcx,[rbx+r8*4] (112), exit.
;
; Contract: implement `ex_08_lea_scale` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 112
;
.CODE

EXTRN ExitProcess:PROC
EXTERNDEF ex_08_lea_scale:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_08_lea_scale in this file.
    call    ex_08_lea_scale
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
