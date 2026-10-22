; Exercise: 06-clip-test
;
; x=5 w=4 -> outside exit 1.
; Expected stdout: (none)
;
; Contract: implement `ex_06_clip_test` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 1
;
.CODE
EXTRN ExitProcess:PROC
EXTERNDEF ex_06_clip_test:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_06_clip_test in this file.
    call    ex_06_clip_test
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
