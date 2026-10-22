; Exercise: 26-stretch-atoi
;
; STRETCH: parse "42" decimal ascii into rcx (42) with a loop.
;
; Contract: implement `ex_26_stretch_atoi` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 42
;
.CODE

EXTRN ExitProcess:PROC
EXTERNDEF ex_26_stretch_atoi:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_26_stretch_atoi in this file.
    call    ex_26_stretch_atoi
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
