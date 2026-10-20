; Exercise 05: save magic
;
; Magic 'PK01' first byte 'P'=80; exit 80.
;
; Build: ml64 /c 05-save-magic.asm && link /OUT:05-save-magic.exe /ENTRY:main /SUBSYSTEM:CONSOLE 05-save-magic.obj kernel32.lib
;
; Expected exit: 80
; Expected stdout: (none)

EXTERN ExitProcess:PROC

.data
magic BYTE "PK01"

.code
main PROC
    sub rsp, 32
    movzx rcx, BYTE PTR [magic]
    call ExitProcess
main ENDP
END
