; Exercise: 19-strcmp-lite
;
; Compare 'ab' and 'ab' bytewise; exit 0 if equal else 1. Should exit 0.
;
; Contract: implement `ex_19_strcmp_lite` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 0
;
.CODE

EXTRN ExitProcess:PROC
EXTERNDEF ex_19_strcmp_lite:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_19_strcmp_lite in this file.
    call    ex_19_strcmp_lite
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
