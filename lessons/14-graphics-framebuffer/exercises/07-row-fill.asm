; Exercise: 07-row-fill
;
; Fill 3 pixels with 9; exit mid.
; Expected stdout: (none)
;
; Contract: implement `ex_07_row_fill` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 9
;
.CODE
EXTRN ExitProcess:PROC
EXTERNDEF ex_07_row_fill:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_07_row_fill in this file.
    call    ex_07_row_fill
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
