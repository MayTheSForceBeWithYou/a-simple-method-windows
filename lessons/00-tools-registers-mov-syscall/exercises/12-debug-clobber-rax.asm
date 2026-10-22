; Exercise 12: debug clobber rax
;
; BUG HUNT: Should write "X\n" then exit 0. Register set wrong before write. Fix.
;
; Build: ml64 /c 12-debug-clobber-rax.asm && link /OUT:12-debug-clobber-rax.exe /ENTRY:main /SUBSYSTEM:CONSOLE 12-debug-clobber-rax.obj kernel32.lib
;
; Expected exit: 0


.DATA
msg BYTE "X", 13, 10
msg_len EQU $ - msg

.CODE

EXTRN ExitProcess:PROC
EXTRN ex_12_debug_clobber_rax:PROC

main PROC
    sub     rsp, 40
    ; Broken starter (implement corrected logic in student routine):
    jmp     __ex_call
    mov rcx, 1    ; BUG: fix in ex_12_debug_clobber_rax
    mov rdx, msg    ; BUG: fix in ex_12_debug_clobber_rax
    mov rdx, msg_len    ; BUG: fix in ex_12_debug_clobber_rax
    mov rax, 60    ; BUG: fix in ex_12_debug_clobber_rax
    ; syscall removed — use ExitProcess in student routine
    mov rax, 60    ; BUG: fix in ex_12_debug_clobber_rax
    xor rdi, rdi    ; BUG: fix in ex_12_debug_clobber_rax
    ; syscall removed — use ExitProcess in student routine
__ex_call:
    ; TODO: write ex_12_debug_clobber_rax in this file.
    call    ex_12_debug_clobber_rax
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
