; Exercise: 22-stretch-flow-field
;
; STRETCH: flow cell cost 4; exit 4.
; Expected stdout: (none)
;
; Contract: implement `ex_22_stretch_flow_field` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 4
;
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_22_stretch_flow_field:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_22_stretch_flow_field in this file.
    call    ex_22_stretch_flow_field
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
