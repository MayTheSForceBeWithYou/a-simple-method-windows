; Exercise: 12-strcat-lite
;
; dst="Hi", append "!", final length=3.
;
; Contract: implement `ex_12_strcat_lite` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 3
;
.CODE
EXTRN ExitProcess:PROC
EXTERNDEF ex_12_strcat_lite:PROC



main PROC
    sub     rsp, 40

    ; TODO: write ex_12_strcat_lite in this file.
    call    ex_12_strcat_lite
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
