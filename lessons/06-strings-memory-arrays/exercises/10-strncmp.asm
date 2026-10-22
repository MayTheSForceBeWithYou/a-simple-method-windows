; Exercise 10: 10-strncmp (Win32 port)
; strncmp first 2 of "axy","abz" equal -> 0.
; Build: ml64 /c /Fo10-strncmp.obj 10-strncmp.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:10-strncmp.exe 10-strncmp.obj kernel32.lib

.CODE
EXTRN ExitProcess:PROC
EXTRN ex_10_strncmp:PROC

; TODO: Port from NASM to MASM (MS x64 ABI)

main PROC
    sub     rsp, 32
    ; TODO: Implement
    ; TODO: implement ex_10_strncmp (student routine; defined in solutions/).
    call    ex_10_strncmp
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
