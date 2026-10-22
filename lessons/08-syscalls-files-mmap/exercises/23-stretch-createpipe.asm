; Exercise: 23-stretch-createpipe
;
; CreatePipe, write "ABC" through the pipe, read it back; exit 3 (byte count).
;
; Contract: implement `ex_23_stretch_createpipe` (MS x64). Return exit code in EAX.
; Expected exit: 3

.CODE

EXTRN ExitProcess:PROC
EXTRN ex_23_stretch_createpipe:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_23_stretch_createpipe in this file.
    call    ex_23_stretch_createpipe
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
