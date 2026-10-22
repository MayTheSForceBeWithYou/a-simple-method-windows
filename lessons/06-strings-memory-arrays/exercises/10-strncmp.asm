; Exercise: 10-strncmp
;
; strncmp first 2 of "abx","abz" -> 0 (equal for n=2).
;
; Contract: implement `ex_10_strncmp` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 0
;
.CODE
EXTRN ExitProcess:PROC
EXTERNDEF ex_10_strncmp:PROC



main PROC
    sub     rsp, 40

    ; TODO: write ex_10_strncmp in this file.
    call    ex_10_strncmp
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
