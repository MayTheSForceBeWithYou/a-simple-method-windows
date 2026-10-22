; Exercise: 03-memcmp
;
; memcmp 3 bytes; equal -> 0.
;
; Contract: implement `ex_03_memcmp` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 0
;
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_03_memcmp:PROC



main PROC
    sub     rsp, 40

    ; TODO: write ex_03_memcmp in this file.
    call    ex_03_memcmp
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
