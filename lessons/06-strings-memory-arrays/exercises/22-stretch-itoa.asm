; Exercise: 22-stretch-itoa
;
; STRETCH: itoa 123 into buffer; return length 3.
; Expected stdout: (none)
;
; Contract: implement `ex_22_stretch_itoa` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 3
;
.CODE
EXTRN ExitProcess:PROC
EXTERNDEF ex_22_stretch_itoa:PROC



main PROC
    sub     rsp, 40

    ; TODO: write ex_22_stretch_itoa in this file.
    call    ex_22_stretch_itoa
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
