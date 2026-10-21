; Exercise 15: debug wrong arg reg (Win32 port)
; BUG: second arg in wrong register. add(2,40) should=42. Fix MS x64 arg regs.
; Build: ml64 /c /Fo15-debug-wrong-arg-reg.obj 15-debug-wrong-arg-reg.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:15-debug-wrong-arg-reg.exe 15-debug-wrong-arg-reg.obj kernel32.lib
; Expected exit: 42
; Expected stdout: (none)
.CODE
EXTRN ExitProcess:PROC

add2 PROC
    ; BUG: Expects RCX and RDX, not RDI/RSI
    mov rax, rcx
    add rax, rdx
    ret
add2 ENDP

main PROC
    sub rsp, 32
    mov rcx, 2
    mov rsi, 40                ; BUG: Should be RDX, not RSI!

    ; TODO: complete exercise (scaffold uses wrong exit code)
    mov ecx, 0
    call ExitProcess
main ENDP
END
