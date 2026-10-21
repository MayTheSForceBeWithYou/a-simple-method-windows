; Exercise 07: panel draw stub
;
; Draw count 3 widgets; exit 3.
;
; Build: ml64 /c 07-panel-draw-stub.asm && link /OUT:07-panel-draw-stub.exe /ENTRY:main /SUBSYSTEM:CONSOLE 07-panel-draw-stub.obj kernel32.lib
;
; Expected exit: 3
; Expected stdout: (none)

EXTERN ExitProcess:PROC

.code
main PROC
    sub rsp, 40
    mov rcx, 3
    call ExitProcess
main ENDP
END
