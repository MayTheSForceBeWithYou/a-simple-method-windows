; Exercise 19: debug lea load
;
; BUG: used lea to 'load' value. Fix to mov from memory; x QWORD 55; exit 55.
;
; Build: ml64 /c 19-debug-lea-load.asm && link /OUT:19-debug-lea-load.exe /ENTRY:main /SUBSYSTEM:CONSOLE 19-debug-lea-load.obj kernel32.lib
;
; Expected exit: 55


.DATA
x QWORD 55

.CODE

EXTRN ExitProcess:PROC
EXTRN ex_19_debug_lea_load:PROC

main PROC
    sub     rsp, 40
    ; Broken starter (implement corrected logic in student routine):
    jmp     __ex_call
    lea rcx, x    ; BUG: fix in ex_19_debug_lea_load (should load value, not address)
    mov rax, 60    ; BUG: fix in ex_19_debug_lea_load
    ; syscall removed — use ExitProcess in student routine
__ex_call:
    ; TODO: write ex_19_debug_lea_load in this file.
    call    ex_19_debug_lea_load
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
