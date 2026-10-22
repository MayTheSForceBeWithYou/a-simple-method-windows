; Exercise 13: debug bad length
;
; BUG HUNT: Writes "Hi\n" but length parameter too short. Fix via EQU.
;
; Build: ml64 /c 13-debug-bad-length.asm && link /OUT:13-debug-bad-length.exe /ENTRY:main /SUBSYSTEM:CONSOLE 13-debug-bad-length.obj kernel32.lib
;
; Expected exit: 0


.CODE

EXTRN ExitProcess:PROC
EXTRN ex_13_debug_bad_length:PROC

main PROC
    sub     rsp, 40
    ; Broken starter (implement corrected logic in student routine):
    jmp     __ex_call
    mov rax, 1    ; BUG: fix in ex_13_debug_bad_length
    mov rcx, 1    ; BUG: fix in ex_13_debug_bad_length
    mov rdx, msg    ; BUG: fix in ex_13_debug_bad_length
    mov rdx, 2    ; BUG: fix in ex_13_debug_bad_length
    ; syscall removed — use ExitProcess in student routine
    mov rax, 60    ; BUG: fix in ex_13_debug_bad_length
    xor rdi, rdi    ; BUG: fix in ex_13_debug_bad_length
    ; syscall removed — use ExitProcess in student routine
__ex_call:
    ; TODO: write ex_13_debug_bad_length in this file.
    call    ex_13_debug_bad_length
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
