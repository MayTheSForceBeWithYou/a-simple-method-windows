; Exercise: 04-memset
;
; memset 4 bytes to 7; sum=28.
;
; Contract: implement `ex_04_memset` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 28
;
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_04_memset:PROC



main PROC
    sub     rsp, 40

    ; TODO: write ex_04_memset in this file.
    call    ex_04_memset
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
