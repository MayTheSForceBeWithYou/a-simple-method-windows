; Exercise: 22-stretch-coaster-excitement
;
; STRETCH: excitement score 42; exit 42.
; Expected stdout: (none)
;
; Contract: implement `ex_22_stretch_coaster_excitement` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 42
;
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_22_stretch_coaster_excitement:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_22_stretch_coaster_excitement in this file.
    call    ex_22_stretch_coaster_excitement
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
