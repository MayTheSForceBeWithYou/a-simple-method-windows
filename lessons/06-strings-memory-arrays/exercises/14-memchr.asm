; Exercise 14: 14-memchr (Win32 port)
; Find 7 in bytes 3,5,7,9; index 2.
; Build: ml64 /c /Fo14-memchr.obj 14-memchr.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:14-memchr.exe 14-memchr.obj kernel32.lib

.CODE
EXTRN ExitProcess:PROC

; TODO: Port from NASM to MASM (MS x64 ABI)

main PROC
    sub rsp, 32
    ; TODO: Implement

    ; TODO: complete exercise (scaffold uses wrong exit code)
    mov ecx, 1
    call ExitProcess
main ENDP
END
