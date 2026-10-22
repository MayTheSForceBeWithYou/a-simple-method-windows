; Exercise: 13-rect-fill
;
; Fill 2x2 rect with 3; sum=12.
; Expected stdout: (none)
;
; Contract: implement `ex_13_rect_fill` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 12
;
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_13_rect_fill:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_13_rect_fill in this file.
    call    ex_13_rect_fill
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
