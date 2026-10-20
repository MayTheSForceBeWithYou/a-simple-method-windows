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
    .ERR <TODO: CreatePipe with pointers to handles>
    
    ; TODO: CloseHandle both handles
    .ERR <TODO: CloseHandle(hReadPipe), CloseHandle(hWritePipe)>
    
    xor     ecx, ecx
    add     rsp, 40
    call    ExitProcess
main ENDP

END
