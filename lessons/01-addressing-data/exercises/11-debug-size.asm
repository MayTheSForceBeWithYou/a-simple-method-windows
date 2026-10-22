; Exercise 11: debug size
;
; BUG: mov [buf], 1 ambiguous/wrong. Store BYTE 1, load movzx rcx, exit.
;
; Build: ml64 /c 11-debug-size.asm && link /OUT:11-debug-size.exe /ENTRY:main /SUBSYSTEM:CONSOLE 11-debug-size.obj kernel32.lib
;
; Expected exit: 1


.CODE

EXTRN ExitProcess:PROC
EXTRN ex_11_debug_size:PROC

main PROC
    sub     rsp, 40
    ; Broken starter (implement corrected logic in student routine):
    jmp     __ex_call
    mov [buf], 1    ; BUG: fix in ex_11_debug_size
    movzx rdi, byte [buf]    ; BUG: fix in ex_11_debug_size
    mov rax, 60    ; BUG: fix in ex_11_debug_size
    ; syscall removed — use ExitProcess in student routine
__ex_call:
    ; TODO: write ex_11_debug_size in this file.
    call    ex_11_debug_size
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
