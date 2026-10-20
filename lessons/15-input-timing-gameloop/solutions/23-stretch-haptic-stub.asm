; Exercise 23: stretch haptic stub
;
; STRETCH: rumble frames remaining 2; exit 2.
;
; Build: ml64 /c 23-stretch-haptic-stub.asm && link /OUT:23-stretch-haptic-stub.exe /ENTRY:main /SUBSYSTEM:CONSOLE 23-stretch-haptic-stub.obj kernel32.lib
;
; Expected exit: 2
; Expected stdout: (none)

EXTERN ExitProcess:PROC

.data?
rumble QWORD ?

.code
main PROC
    sub rsp, 32
    mov QWORD PTR [rumble], 2
    mov rcx, [rumble]
    call ExitProcess
main ENDP
END
