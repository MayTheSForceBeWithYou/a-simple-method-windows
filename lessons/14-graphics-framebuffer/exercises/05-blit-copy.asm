; Exercise: 05-blit-copy
;
; Copy 4 bytes src->dst; sum exit 10.
; Expected stdout: (none)
;
; Contract: implement `ex_05_blit_copy` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 10
;
.CODE
EXTRN ExitProcess:PROC
EXTERNDEF ex_05_blit_copy:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_05_blit_copy in this file.
    call    ex_05_blit_copy
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
