; Exercise: 24-from-scratch-reverse-string
;
; FROM SCRATCH: reverse "asm" in place; first byte should be "m"=109.
; Expected stdout: (none)
;
; Contract: implement `ex_24_from_scratch_reverse_string` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 109
;
.CODE
EXTRN ExitProcess:PROC
EXTERNDEF ex_24_from_scratch_reverse_string:PROC



main PROC
    sub     rsp, 40

    ; TODO: write ex_24_from_scratch_reverse_string in this file.
    call    ex_24_from_scratch_reverse_string
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
