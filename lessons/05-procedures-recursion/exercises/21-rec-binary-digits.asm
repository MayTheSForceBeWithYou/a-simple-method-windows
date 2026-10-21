; Exercise 21: 21-rec-binary-digits.asm (Win32 port)
; Count bits set via recursion clearing lowbit. popcount(0b1101)=3; exit 3.
; Build: ml64 /c /Fo21-rec-binary-digits.asm.obj 21-rec-binary-digits.asm.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:21-rec-binary-digits.asm.exe 21-rec-binary-digits.asm.obj kernel32.lib
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
