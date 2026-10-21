; Exercise 03: 03-memcmp (Win32 port)
; memcmp 3 bytes; equal -> 0 exit.
; Build: ml64 /c /Fo03-memcmp.obj 03-memcmp.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:03-memcmp.exe 03-memcmp.obj kernel32.lib

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
