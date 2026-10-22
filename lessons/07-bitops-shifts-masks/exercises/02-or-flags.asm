; Exercise: 02-or-flags
;
; Set bits 0 and 2; exit 5.
;
; Contract: implement `ex_02_or_flags` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 5
;
.CODE

EXTRN ExitProcess:PROC
EXTERNDEF ex_02_or_flags:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_02_or_flags in this file.
    call    ex_02_or_flags
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
