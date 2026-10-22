; Exercise 11: debug wrong syscall
;
; BUG HUNT: Intends to exit status 3 but uses wrong function. Fix it.
;
; Build: ml64 /c 11-debug-wrong-syscall.asm && link /OUT:11-debug-wrong-syscall.exe /ENTRY:main /SUBSYSTEM:CONSOLE 11-debug-wrong-syscall.obj kernel32.lib
;
; Expected exit: 3


.CODE

EXTRN ExitProcess:PROC
EXTRN ex_11_debug_wrong_syscall:PROC

main PROC
    sub     rsp, 40
    ; Broken starter (implement corrected logic in student routine):
    jmp     __ex_call
    mov rax, 1    ; BUG: fix in ex_11_debug_wrong_syscall
    mov rcx, 3    ; BUG: fix in ex_11_debug_wrong_syscall
    ; syscall removed — use ExitProcess in student routine
__ex_call:
    ; TODO: write ex_11_debug_wrong_syscall in this file.
    call    ex_11_debug_wrong_syscall
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
