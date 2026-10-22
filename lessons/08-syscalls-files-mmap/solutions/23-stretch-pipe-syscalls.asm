; Exercise 23: stretch pipe note
;
; STRETCH: CreatePipe into handles; if success exit 0. (Should work)
;
; Build: ml64 /c 23-stretch-pipe-syscalls.asm && link /OUT:23-stretch-pipe-syscalls.exe /ENTRY:main /SUBSYSTEM:CONSOLE 23-stretch-pipe-syscalls.obj kernel32.lib
;
; Expected exit: 0

EXTERN CreatePipe:PROC
EXTERN ExitProcess:PROC

.data?
hReadPipe QWORD ?
hWritePipe QWORD ?

.code
ex_23_stretch_pipe_syscalls PROC
    sub rsp, 40
    
    ; CreatePipe(&hReadPipe, &hWritePipe, NULL, 0)
    lea rcx, hReadPipe
    lea rdx, hWritePipe
    mov r8, 0               ; lpPipeAttributes = NULL
    mov r9d, 0              ; nSize = 0 (default)
    call CreatePipe
    
    ; Returns nonzero on success
    test rax, rax
    jz L_fail
    
    ; Success - exit 0
    mov rcx, 0
    jmp L_o
    
L_fail:
    ; Failure - exit 1
    mov rcx, 1
    
L_o:
    mov     eax, 0
    add     rsp, 40
    ret
ex_23_stretch_pipe_syscalls ENDP
main PROC
    sub     rsp, 40
    call    ex_23_stretch_pipe_syscalls
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
