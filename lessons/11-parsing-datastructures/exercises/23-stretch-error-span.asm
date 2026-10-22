; Exercise: 23-stretch-error-span
;
; STRETCH: error at offset 4 length 1; exit 4.
;
; Contract: implement `ex_23_stretch_error_span` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 4
;
.CODE
EXTRN ExitProcess:PROC
EXTERNDEF ex_23_stretch_error_span:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_23_stretch_error_span in this file.
    call    ex_23_stretch_error_span
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
