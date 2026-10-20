; Exercise 06: save stub
;
; Pretend save ok; exit 0.
;
; Build: ml64 /c 06-save-stub.asm && link /OUT:06-save-stub.exe /ENTRY:main /SUBSYSTEM:CONSOLE 06-save-stub.obj kernel32.lib
;
; Expected exit: 0

EXTERN ExitProcess:PROC

.code
main PROC
    sub rsp, 32
    mov rcx, 0
    call ExitProcess
main ENDP
END
