; Exercise: 18-reuse-regs-safely
;
; Exercise 18: reuse regs safely
; Write "ok\n", then exit 0. Re-load parameters after write (registers may be clobbered).
;
; Contract: implement `ex_18_reuse_regs_safely` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 0
;

; Exercise 18: reuse regs safely
;
; Write "ok\n", then exit 0. Re-load parameters after write (registers may be clobbered).
;
; Build: ml64 /c 18-reuse-regs-safely.asm && link /OUT:18-reuse-regs-safely.exe /ENTRY:main /SUBSYSTEM:CONSOLE 18-reuse-regs-safely.obj kernel32.lib
;
; Expected exit: 0

.CODE

EXTRN ExitProcess:PROC
EXTRN ex_18_reuse_regs_safely:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_18_reuse_regs_safely in this file.
    call    ex_18_reuse_regs_safely
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
