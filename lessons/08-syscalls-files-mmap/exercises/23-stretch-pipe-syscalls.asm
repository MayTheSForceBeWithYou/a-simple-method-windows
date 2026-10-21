; 23-stretch-pipe-syscalls.asm (stretch)
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

EXTRN CreatePipe:PROC
EXTRN CloseHandle:PROC
EXTRN ExitProcess:PROC

main PROC FRAME
    sub     rsp, 40
    .allocstack 40
    .endprolog
    
    ; TODO: CreatePipe(&hReadPipe, &hWritePipe, NULL, 0)
    
    ; TODO: CloseHandle both handles
    mov ecx, 1
    call ExitProcess
main ENDP

END
