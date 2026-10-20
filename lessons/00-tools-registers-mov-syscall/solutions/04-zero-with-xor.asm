; Exercise 04: zero with xor
;
; Zero rdi using xor, then exit 0. No mov immediate.
;
; Build: ml64 /c 04-zero-with-xor.asm && link /OUT:04-zero-with-xor.exe /ENTRY:main /SUBSYSTEM:CONSOLE 04-zero-with-xor.obj kernel32.lib
;
; Expected exit: 0

EXTERN ExitProcess:PROC

.code
main PROC
    sub rsp, 32
    xor rcx, rcx
    call ExitProcess
main ENDP
END
