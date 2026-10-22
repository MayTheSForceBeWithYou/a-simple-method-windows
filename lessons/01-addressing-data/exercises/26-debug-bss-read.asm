; Exercise: 26-debug-bss-read
;
; Exercise 26: debug bss read
; BUG: reads .data? before store (0). Store 12 first; exit 12.
;
; Contract: implement `ex_26_debug_bss_read` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 12
;

; Exercise 26: debug bss read
;
; BUG: reads .data? before store (0). Store 12 first; exit 12.
;
; Build: ml64 /c 26-debug-bss-read.asm && link /OUT:26-debug-bss-read.exe /ENTRY:main /SUBSYSTEM:CONSOLE 26-debug-bss-read.obj kernel32.lib
;
; Expected exit: 12

.DATA?
v QWORD ?

.CODE

EXTRN ExitProcess:PROC
EXTRN ex_26_debug_bss_read:PROC

main PROC
    sub     rsp, 40
    ; Broken starter (implement corrected logic in student routine):
    jmp     __ex_call
    mov rcx, QWORD PTR [v]    ; BUG: fix in ex_26_debug_bss_read

__ex_call:
    ; TODO: write ex_26_debug_bss_read in this file.
    call    ex_26_debug_bss_read
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
