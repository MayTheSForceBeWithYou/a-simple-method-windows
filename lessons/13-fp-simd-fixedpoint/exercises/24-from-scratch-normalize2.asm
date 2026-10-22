; Exercise: 24-from-scratch-normalize2
;
; Length of (3,4) vector; exit 5.
;
; Contract: implement `ex_24_from_scratch_normalize2` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 5
;
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_24_from_scratch_normalize2:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_24_from_scratch_normalize2 in this file.
    call    ex_24_from_scratch_normalize2
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
