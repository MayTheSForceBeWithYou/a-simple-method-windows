; Exercise: 08-div-remainder
;
; Unsigned: 20 / 6. Exit with remainder (rdx) = 2.
;
; Contract: implement `ex_08_div_remainder` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 2
;
.CODE

EXTRN ExitProcess:PROC
EXTRN ex_08_div_remainder:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_08_div_remainder in this file.
    call    ex_08_div_remainder
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
