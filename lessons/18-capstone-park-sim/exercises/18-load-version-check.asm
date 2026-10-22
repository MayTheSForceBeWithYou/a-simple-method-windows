; Exercise: 18-load-version-check
;
; version==1 ok exit 1.
; Expected stdout: (none)
;
; Contract: implement `ex_18_load_version_check` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 1
;
.CODE
EXTRN ExitProcess:PROC
EXTERNDEF ex_18_load_version_check:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_18_load_version_check in this file.
    call    ex_18_load_version_check
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
