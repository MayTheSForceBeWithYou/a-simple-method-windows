; Exercise: 23-stretch-haptic-stub
;
; STRETCH: rumble frames remaining 2; exit 2.
; Expected stdout: (none)
;
; Contract: implement `ex_23_stretch_haptic_stub` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 2
;
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_23_stretch_haptic_stub:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_23_stretch_haptic_stub in this file.
    call    ex_23_stretch_haptic_stub
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
