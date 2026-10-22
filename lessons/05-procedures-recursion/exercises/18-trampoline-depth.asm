; Exercise 18: 18-trampoline-depth.asm (Win32 port)
; bump_depth(n) adds n via recursion; n=8 exit 8.
; Build: ml64 /c /Fo18-trampoline-depth.asm.obj 18-trampoline-depth.asm.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:18-trampoline-depth.asm.exe 18-trampoline-depth.asm.obj kernel32.lib
; Expected: see original exercise

.CODE
EXTRN ExitProcess:PROC
EXTRN ex_18_trampoline_depth:PROC

; TODO: Port from NASM to MASM

main PROC
    sub     rsp, 40
    ; TODO: Implement
    ; TODO: write ex_18_trampoline_depth in this file.
    call    ex_18_trampoline_depth
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
