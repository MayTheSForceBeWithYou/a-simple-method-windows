; Exercise 20: 20-count-char (Win32 port)
; Count 's' in 'mississippi' -> 4.
; Build: ml64 /c /Fo20-count-char.obj 20-count-char.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:20-count-char.exe 20-count-char.obj kernel32.lib

.CODE
EXTRN ExitProcess:PROC

; TODO: Port from NASM to MASM (MS x64 ABI)
.ERR <TODO: Implement 20-count-char>

main PROC
    sub rsp, 32
    ; TODO: Implement
    .ERR <TODO: Complete implementation>
main ENDP
END
