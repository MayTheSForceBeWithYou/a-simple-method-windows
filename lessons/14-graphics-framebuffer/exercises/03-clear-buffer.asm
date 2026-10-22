; Exercise: 03-clear-buffer
;
; Clear 8 bytes to 0; exit first byte 0.
; Expected stdout: (none)
;
; Contract: implement `ex_03_clear_buffer` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 0
;
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_03_clear_buffer:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_03_clear_buffer in this file.
    call    ex_03_clear_buffer
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
