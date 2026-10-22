; Exercise: 11-component-mask
;
; Has POS|VEL = 3; exit 3.
; Expected stdout: (none)
;
; Contract: implement `ex_11_component_mask` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 3
;
.CODE
EXTRN ExitProcess:PROC
EXTERNDEF ex_11_component_mask:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_11_component_mask in this file.
    call    ex_11_component_mask
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
