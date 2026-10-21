; Exercise 27: debug stack imbalance (Win32 port)
; BUG: extra push without pop before ret corrupts return. Fix; exit 2.
; Build: ml64 /c /Fo27-debug-stack-imbalance.obj 27-debug-stack-imbalance.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:27-debug-stack-imbalance.exe 27-debug-stack-imbalance.obj kernel32.lib
; Expected: exit code 2

.CODE
EXTRN ExitProcess:PROC

get_two PROC
    push rax                   ; BUG: Pushed but never popped!
    mov rax, 2
    ret
get_two ENDP

main PROC
    sub rsp, 32
    call get_two
    mov rcx, rax
    call ExitProcess
main ENDP
END
