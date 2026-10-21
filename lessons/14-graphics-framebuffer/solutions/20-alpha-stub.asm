; Exercise 20: alpha stub
;
; Alpha blend stub: out=src if a=255; exit 7.
;
; Build: ml64 /c 20-alpha-stub.asm && link /OUT:20-alpha-stub.exe /ENTRY:main /SUBSYSTEM:CONSOLE 20-alpha-stub.obj kernel32.lib
;
; Expected exit: 7
; Expected stdout: (none)

EXTERN ExitProcess:PROC

.code
main PROC
    sub rsp, 40
    mov rcx, 7
    call ExitProcess
main ENDP
END
