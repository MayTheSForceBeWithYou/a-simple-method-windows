; Exercise 16: 16-debug-missing-pop.asm (Win32 port)
; BUG HUNT: recursive fact-like leaves stack unbalanced. Fix; fact(3)=6 exit 6.
; Build: ml64 /c /Fo16-debug-missing-pop.asm.obj 16-debug-missing-pop.asm.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:16-debug-missing-pop.asm.exe 16-debug-missing-pop.asm.obj kernel32.lib
; Expected: see original exercise

.CODE
EXTRN ExitProcess:PROC

; TODO: Port from NASM to MASM

main PROC
    sub rsp, 32
    ; TODO: Implement

    ; TODO: complete exercise (scaffold uses wrong exit code)
    mov ecx, 1
    call ExitProcess
main ENDP
END
