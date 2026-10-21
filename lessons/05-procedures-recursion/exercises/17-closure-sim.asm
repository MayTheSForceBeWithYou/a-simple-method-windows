; Exercise 17: 17-closure-sim.asm (Win32 port)
; Pass context pointer in r12 (callee-saved): ctx dq 10; add_ctx(rdi) returns rdi+[ctx]. Call with 5 -> 15.
; Build: ml64 /c /Fo17-closure-sim.asm.obj 17-closure-sim.asm.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:17-closure-sim.asm.exe 17-closure-sim.asm.obj kernel32.lib
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
