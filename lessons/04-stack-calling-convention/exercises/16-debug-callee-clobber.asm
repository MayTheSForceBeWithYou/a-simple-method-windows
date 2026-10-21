; Exercise 16: debug callee clobber (Win32 port)
; BUG: callee clobbers RBX without saving. Fix by adding PUSH/POP. Exit 11.
; Build: ml64 /c /Fo16-debug-callee-clobber.obj 16-debug-callee-clobber.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:16-debug-callee-clobber.exe 16-debug-callee-clobber.obj kernel32.lib
; Expected: exit code 11

.CODE
EXTRN ExitProcess:PROC

helper PROC
    ; BUG: Uses RBX without saving (nonvolatile!)
    mov rbx, 99
    mov rax, 1
    ret
helper ENDP

main PROC
    sub rsp, 32
    mov rbx, 11
    call helper
    mov rcx, rbx               ; Should still be 11
    call ExitProcess
main ENDP
END
