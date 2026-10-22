; Exercise: 09-key-down-up
;
; Track key state: down sets, up clears; exit 0.
; Expected stdout: (none)
;
; Contract: implement `ex_09_key_down_up` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 0
;
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_09_key_down_up:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_09_key_down_up in this file.
    call    ex_09_key_down_up
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
