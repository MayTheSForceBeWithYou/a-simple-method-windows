; Exercise 15: 15-rec-strlen.asm (Win32 port)
; Recursive strlen on "abcd"; exit 4.
; Build: ml64 /c /Fo15-rec-strlen.asm.obj 15-rec-strlen.asm.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:15-rec-strlen.asm.exe 15-rec-strlen.asm.obj kernel32.lib
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
