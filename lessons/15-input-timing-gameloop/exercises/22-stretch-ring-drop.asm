; Exercise: 22-stretch-ring-drop
;
; STRETCH: input ring full drops; dropped count 1; exit 1.
; Expected stdout: (none)
;
; Contract: implement `ex_22_stretch_ring_drop` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 1
;
.CODE
EXTRN ExitProcess:PROC
EXTERNDEF ex_22_stretch_ring_drop:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_22_stretch_ring_drop in this file.
    call    ex_22_stretch_ring_drop
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
