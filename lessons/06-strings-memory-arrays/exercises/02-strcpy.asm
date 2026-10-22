; Exercise 02: 02-strcpy (Win32 port)
; Copy 'yo' to bss; return length written 2; exit 2.
; Build: ml64 /c /Fo02-strcpy.obj 02-strcpy.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:02-strcpy.exe 02-strcpy.obj kernel32.lib

.CODE
EXTRN ExitProcess:PROC
EXTRN ex_02_strcpy:PROC

; TODO: Port from NASM to MASM (MS x64 ABI)

main PROC
    sub     rsp, 40
    ; TODO: Implement
    ; TODO: write ex_02_strcpy in this file.
    call    ex_02_strcpy
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
