; Exercise 01: 01-strlen (Win32 port)
; Implement strlen; 'hello' -> 5.
; Build: ml64 /c /Fo01-strlen.obj 01-strlen.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:01-strlen.exe 01-strlen.obj kernel32.lib

.CODE
EXTRN ExitProcess:PROC
EXTRN ex_01_strlen:PROC

; TODO: Port from NASM to MASM (MS x64 ABI)

main PROC
    sub     rsp, 32
    ; TODO: Implement
    ; TODO: implement ex_01_strlen (student routine; defined in solutions/).
    call    ex_01_strlen
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
