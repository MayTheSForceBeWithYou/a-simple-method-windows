; Exercise: 05-save-magic
;
; Magic 'PK01' first byte 'P'=80; exit 80.
; Expected stdout: (none)
;
; Contract: implement `ex_05_save_magic` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 80
;
.CODE
EXTRN ExitProcess:PROC
EXTERNDEF ex_05_save_magic:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_05_save_magic in this file.
    call    ex_05_save_magic
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
