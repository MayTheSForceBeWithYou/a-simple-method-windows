; Exercise 18: 18-trampoline-depth.asm (Win32 port)
; bump_depth(n) adds n via recursion; n=8 exit 8.
; Build: ml64 /c /Fo18-trampoline-depth.asm.obj 18-trampoline-depth.asm.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:18-trampoline-depth.asm.exe 18-trampoline-depth.asm.obj kernel32.lib
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
