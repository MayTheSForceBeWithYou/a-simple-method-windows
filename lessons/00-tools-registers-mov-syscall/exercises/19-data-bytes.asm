; Exercise: 19-data-bytes
;
; Emit bytes 048h 069h 00Ah (Hi newline) using BYTE. Write them; exit 0.
;
; Contract: implement `ex_19_data_bytes` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 0
;
.CODE

EXTRN ExitProcess:PROC
EXTRN ex_19_data_bytes:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_19_data_bytes in this file.
    call    ex_19_data_bytes
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
