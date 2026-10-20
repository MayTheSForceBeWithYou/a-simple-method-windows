; Exercise 12: 12-nested-frame.asm (Win32 port)
; outer calls inner; both have frames. inner returns rdi+rsi; outer adds 1. Call outer(10,20)->31.
; Build: ml64 /c /Fo12-nested-frame.asm.obj 12-nested-frame.asm.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:12-nested-frame.asm.exe 12-nested-frame.asm.obj kernel32.lib
; Expected: see original exercise

.CODE
EXTRN ExitProcess:PROC

; TODO: Port from NASM to MASM
.ERR <TODO: Implement this exercise>

main PROC
    sub rsp, 32
    ; TODO: Implement
    .ERR <TODO: Complete implementation>
main ENDP
END
