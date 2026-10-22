; Exercise 08: two writes (Win32 port)
;
; Write two separate strings to stdout.
;
; Build: ml64 /c /Fo08-two-writes.obj 08-two-writes.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:08-two-writes.exe 08-two-writes.obj kernel32.lib
; Run: 08-two-writes.exe
;
; Expected output: Line one\nLine two\n
; Expected exit: 0
; Expected stdout: (none)
.DATA
msg1 DB "Line one", 13, 10
msg1_len EQU $ - msg1
msg2 DB "Line two", 13, 10
msg2_len EQU $ - msg2

.DATA?
bytes_written DQ ?

.CODE

EXTRN GetStdHandle:PROC
EXTRN WriteFile:PROC
EXTRN ExitProcess:PROC
EXTRN ex_08_two_writes:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_08_two_writes in this file.
    call    ex_08_two_writes
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
