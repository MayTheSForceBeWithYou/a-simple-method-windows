; Exercise 23: 23-stretch-memo-fib-slot.asm (Win32 port)
; STRETCH: memo[10] slots; fib with memo fill. fib(8)=21; exit 21.
; Build: ml64 /c /Fo23-stretch-memo-fib-slot.asm.obj 23-stretch-memo-fib-slot.asm.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:23-stretch-memo-fib-slot.asm.exe 23-stretch-memo-fib-slot.asm.obj kernel32.lib
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
