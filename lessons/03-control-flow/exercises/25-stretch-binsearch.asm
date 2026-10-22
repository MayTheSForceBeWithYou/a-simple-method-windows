; Exercise: 25-stretch-binsearch
;
; STRETCH: sorted QWORD 1,3,5,7,9. Binary search for 7; exit index 3.
;
; Contract: implement `ex_25_stretch_binsearch` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 3
;
.CODE

EXTRN ExitProcess:PROC
EXTERNDEF ex_25_stretch_binsearch:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_25_stretch_binsearch in this file.
    call    ex_25_stretch_binsearch
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
