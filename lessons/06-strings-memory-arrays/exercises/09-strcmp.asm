; Exercise 09: 09-strcmp (Win32 port)
; strcmp "abc","abd" -> nonzero (1). Exit 1.
; Build: ml64 /c /Fo09-strcmp.obj 09-strcmp.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:09-strcmp.exe 09-strcmp.obj kernel32.lib

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
