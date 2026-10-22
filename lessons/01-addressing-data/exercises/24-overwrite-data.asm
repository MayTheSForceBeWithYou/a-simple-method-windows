; Exercise: 24-overwrite-data
;
; msg BYTE 'x',CR,LF. Change first byte to 'Y' in place, write 3 bytes, exit 0.
;
; Contract: implement `ex_24_overwrite_data` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 0
;
.CODE

EXTRN ExitProcess:PROC
EXTERNDEF ex_24_overwrite_data:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_24_overwrite_data in this file.
    call    ex_24_overwrite_data
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
