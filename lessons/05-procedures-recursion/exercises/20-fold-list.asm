; Exercise 20: 20-fold-list.asm (Win32 port)
; Null-terminated qword list (0 sentinel): 3,4,5,0. fold add via proc; exit 12.
; Build: ml64 /c /Fo20-fold-list.asm.obj 20-fold-list.asm.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:20-fold-list.asm.exe 20-fold-list.asm.obj kernel32.lib
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
