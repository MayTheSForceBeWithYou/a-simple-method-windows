; Exercise 04: 04-memset (Win32 port)
; memset 4 bytes to 7; sum=28; exit 28.
; Build: ml64 /c /Fo04-memset.obj 04-memset.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:04-memset.exe 04-memset.obj kernel32.lib

.CODE
EXTRN ExitProcess:PROC
EXTRN ex_04_memset:PROC

; TODO: Port from NASM to MASM (MS x64 ABI)

main PROC
    sub     rsp, 40
    ; TODO: Implement
    ; TODO: write ex_04_memset in this file.
    call    ex_04_memset
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
