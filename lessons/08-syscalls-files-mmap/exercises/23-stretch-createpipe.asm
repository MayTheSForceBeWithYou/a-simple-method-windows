; 23-stretch-createpipe.asm (stretch)
;
; Create an anonymous pipe, exit 0 (do not read/write).
;
; Task: Call CreatePipe to create a pipe (read and write handles),
;       close both handles, exit 0.
;
; Hint: CreatePipe(&hReadPipe, &hWritePipe, NULL, 0)

.DATA
hReadPipe QWORD ?
hWritePipe QWORD ?

.CODE

EXTRN CloseHandle:PROC
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
