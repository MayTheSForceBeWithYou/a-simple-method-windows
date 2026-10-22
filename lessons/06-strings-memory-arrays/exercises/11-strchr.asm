; Exercise: 11-strchr
;
; Find 'l' in 'hello' -> index 2.
;
; Contract: implement `ex_11_strchr` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 2
;
.CODE
EXTRN ExitProcess:PROC
EXTERNDEF ex_11_strchr:PROC



main PROC
    sub     rsp, 40

    ; TODO: write ex_11_strchr in this file.
    call    ex_11_strchr
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
