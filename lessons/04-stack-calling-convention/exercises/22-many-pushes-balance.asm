; Exercise 22: many pushes balance (Win32 port)
; Push 1,2,3; call sum_top3 that reads from stack. Exit 6.
; Build: ml64 /c /Fo22-many-pushes-balance.obj 22-many-pushes-balance.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:22-many-pushes-balance.exe 22-many-pushes-balance.obj kernel32.lib
; Expected: exit code 6

.CODE
EXTRN ExitProcess:PROC

; TODO: Implement sum_top3 that sums values from stack
.ERR <TODO: Implement sum_top3 reading from stack>

main PROC
    sub rsp, 32
    push 1
    push 2
    push 3
    call sum_top3
    add rsp, 24                ; Clean up pushes
    mov rcx, rax
    call ExitProcess
main ENDP
END
