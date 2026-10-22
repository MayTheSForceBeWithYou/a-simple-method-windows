; Exercise: 27-stretch-sys-write-regs
;
; Exercise 27: stretch sys write regs
; Print "syscall\n" using write API. Exit 0.
;
; Contract: implement `ex_27_stretch_sys_write_regs` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 0
;

; Exercise 27: stretch sys write regs
;
; Print "syscall\n" using write API. Exit 0.
;
; Build: ml64 /c 27-stretch-sys-write-regs.asm && link /OUT:27-stretch-sys-write-regs.exe /ENTRY:main /SUBSYSTEM:CONSOLE 27-stretch-sys-write-regs.obj kernel32.lib
;
; Expected exit: 0

.CODE

EXTRN ExitProcess:PROC
EXTRN ex_27_stretch_sys_write_regs:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_27_stretch_sys_write_regs in this file.
    call    ex_27_stretch_sys_write_regs
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
