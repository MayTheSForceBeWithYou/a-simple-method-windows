; Exercise 18: 18-debug-off-by-one-copy (Win32 port)
; BUG: copies n bytes but forgets NUL. Fix strcpy of "ok"; strlen=2.
; Build: ml64 /c /Fo18-debug-off-by-one-copy.obj 18-debug-off-by-one-copy.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:18-debug-off-by-one-copy.exe 18-debug-off-by-one-copy.obj kernel32.lib

.CODE
EXTRN ExitProcess:PROC

; TODO: Port from NASM to MASM (MS x64 ABI)
.ERR <TODO: Implement 18-debug-off-by-one-copy>

main PROC
    sub rsp, 32
    ; TODO: Implement
    .ERR <TODO: Complete implementation>
main ENDP
END
