; Exercise: 23-stretch-createpipe
;
; CreatePipe, write "ABC", read back; exit byte count (3).
;
; Contract: implement `ex_23_stretch_createpipe` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 3
;
.CODE

EXTRN ExitProcess:PROC
EXTERNDEF ex_23_stretch_createpipe:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_23_stretch_createpipe in this file.
    call    ex_23_stretch_createpipe
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
