; Exercise 22: 22-stretch-itoa (Win32 port)
; STRETCH: itoa 123 into buffer; write then exit 0. Also set len cell=3 and exit 3 instead if no write needed.
; Build: ml64 /c /Fo22-stretch-itoa.obj 22-stretch-itoa.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:22-stretch-itoa.exe 22-stretch-itoa.obj kernel32.lib

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
