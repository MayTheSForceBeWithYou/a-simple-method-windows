; Exercise: 17-save-header
;
; Write magic+version size 8; exit 8.
; Expected stdout: (none)
;
; Contract: implement `ex_17_save_header` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 8
;
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_17_save_header:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_17_save_header in this file.
    call    ex_17_save_header
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
