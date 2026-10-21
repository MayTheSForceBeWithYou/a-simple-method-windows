; Exercise 23: 23-stretch-utf8-ascii-validate (Win32 port)
; STRETCH: validate all bytes <128 in "OK\n"; exit 1 if valid.
; Build: ml64 /c /Fo23-stretch-utf8-ascii-validate.obj 23-stretch-utf8-ascii-validate.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:23-stretch-utf8-ascii-validate.exe 23-stretch-utf8-ascii-validate.obj kernel32.lib

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
