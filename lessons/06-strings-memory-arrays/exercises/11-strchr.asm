; Exercise 11: 11-strchr (Win32 port)
; Find index of "l" in "hello" -> 2.
; Build: ml64 /c /Fo11-strchr.obj 11-strchr.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:11-strchr.exe 11-strchr.obj kernel32.lib

.CODE
EXTRN ExitProcess:PROC
EXTRN ex_11_strchr:PROC

; TODO: Port from NASM to MASM (MS x64 ABI)

main PROC
    sub     rsp, 40
    ; TODO: Implement
    ; TODO: write ex_11_strchr in this file.
    call    ex_11_strchr
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
