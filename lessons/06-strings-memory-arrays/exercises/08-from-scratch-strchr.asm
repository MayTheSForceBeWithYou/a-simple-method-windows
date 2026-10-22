; Exercise: 08-from-scratch-strchr
;
; strchr 'c' in 'abcd' -> index 2.
;
; Contract: implement `ex_08_from_scratch_strchr` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 2
;
.CODE
EXTRN ExitProcess:PROC
EXTERNDEF ex_08_from_scratch_strchr:PROC



main PROC
    sub     rsp, 40

    ; TODO: write ex_08_from_scratch_strchr in this file.
    call    ex_08_from_scratch_strchr
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
