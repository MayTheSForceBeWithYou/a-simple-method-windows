; Exercise 01: exit zero
;
; Exit with status 0 using ExitProcess.
;
; Build: ml64 /c 01-exit-zero.asm && link /OUT:01-exit-zero.exe /ENTRY:main /SUBSYSTEM:CONSOLE 01-exit-zero.obj kernel32.lib
;
; Expected exit: 0


.CODE

EXTRN ExitProcess:PROC
EXTRN ex_01_exit_zero:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_01_exit_zero in this file.
    call    ex_01_exit_zero
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
