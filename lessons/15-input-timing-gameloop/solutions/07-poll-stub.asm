; Exercise 07: poll stub
;
; No event -> exit 0.
;
; Build: ml64 /c 07-poll-stub.asm && link /OUT:07-poll-stub.exe /ENTRY:main /SUBSYSTEM:CONSOLE 07-poll-stub.obj kernel32.lib
;
; Expected exit: 0
; Expected stdout: (none)

EXTERN ExitProcess:PROC

.code
main PROC
    sub rsp, 32
    xor rcx, rcx
    call ExitProcess
main ENDP
END
