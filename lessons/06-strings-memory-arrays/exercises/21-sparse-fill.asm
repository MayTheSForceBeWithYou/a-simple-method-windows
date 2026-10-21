; Exercise 21: 21-sparse-fill (Win32 port)
; Fill every other byte in 8-byte buf with 1; sum=4.
; Build: ml64 /c /Fo21-sparse-fill.obj 21-sparse-fill.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:21-sparse-fill.exe 21-sparse-fill.obj kernel32.lib

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
