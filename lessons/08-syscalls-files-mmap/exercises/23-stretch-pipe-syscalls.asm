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

EXTRN CloseHandle:PROC
EXTRN ExitProcess:PROC
EXTRN ex_23_stretch_pipe_syscalls:PROC

main PROC
    sub     rsp, 40
    ; TODO: implement ex_23_stretch_pipe_syscalls (student routine; defined in solutions/).
    call    ex_23_stretch_pipe_syscalls
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
