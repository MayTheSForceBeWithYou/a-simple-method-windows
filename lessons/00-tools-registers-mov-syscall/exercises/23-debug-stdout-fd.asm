; Exercise 23: debug stdout fd
;
; BUG HUNT: handle is wrong. Fix to stdout.
;
; Build: ml64 /c 23-debug-stdout-fd.asm && link /OUT:23-debug-stdout-fd.exe /ENTRY:main /SUBSYSTEM:CONSOLE 23-debug-stdout-fd.obj kernel32.lib
;
; Expected exit: 0


.DATA
msg BYTE "Hi", 13, 10
msg_len EQU $ - msg

.CODE

EXTRN ExitProcess:PROC
EXTRN ex_23_debug_stdout_fd:PROC

main PROC
    sub     rsp, 40
    ; Broken starter (implement corrected logic in student routine):
    jmp     __ex_call
    mov rax, 1    ; BUG: fix in ex_23_debug_stdout_fd
    mov rcx, 0    ; BUG: fix in ex_23_debug_stdout_fd
    mov rdx, msg    ; BUG: fix in ex_23_debug_stdout_fd
    mov rdx, msg_len    ; BUG: fix in ex_23_debug_stdout_fd
    ; syscall removed — use ExitProcess in student routine
    mov rax, 60    ; BUG: fix in ex_23_debug_stdout_fd
    xor rdi, rdi    ; BUG: fix in ex_23_debug_stdout_fd
    ; syscall removed — use ExitProcess in student routine
__ex_call:
    ; TODO: write ex_23_debug_stdout_fd in this file.
    call    ex_23_debug_stdout_fd
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
