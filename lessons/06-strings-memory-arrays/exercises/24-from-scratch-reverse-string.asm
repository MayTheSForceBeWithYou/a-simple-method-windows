; Exercise 24: 24-from-scratch-reverse-string (Win32 port)
; FROM SCRATCH: reverse "asm" in place; first byte should be "m"=109.
; Build: ml64 /c /Fo24-from-scratch-reverse-string.obj 24-from-scratch-reverse-string.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:24-from-scratch-reverse-string.exe 24-from-scratch-reverse-string.obj kernel32.lib

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
