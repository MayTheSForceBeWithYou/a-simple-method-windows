; Exercise: 05-array-reverse
;
; Reverse [1,2,3,4] in place; exit first=4.
;
; Contract: implement `ex_05_array_reverse` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 4
;
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_05_array_reverse:PROC



main PROC
    sub     rsp, 40

    ; TODO: write ex_05_array_reverse in this file.
    call    ex_05_array_reverse
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
