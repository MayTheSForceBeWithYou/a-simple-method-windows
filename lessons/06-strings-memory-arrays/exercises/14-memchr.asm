; Exercise: 14-memchr
;
; Find 7 in bytes 3,5,7,9; index 2.
; Expected stdout: (none)
;
; Contract: implement `ex_14_memchr` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 2
;
.CODE
EXTRN ExitProcess:PROC
EXTERNDEF ex_14_memchr:PROC



main PROC
    sub     rsp, 40

    ; TODO: write ex_14_memchr in this file.
    call    ex_14_memchr
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
