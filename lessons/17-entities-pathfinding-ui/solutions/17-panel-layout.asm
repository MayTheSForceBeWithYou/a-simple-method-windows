; Exercise 17: panel layout
;
; Stack y += h+pad; h=10 pad=2 twice from 0 -> 24; exit 24.
;
; Build: ml64 /c 17-panel-layout.asm && link /OUT:17-panel-layout.exe /ENTRY:main /SUBSYSTEM:CONSOLE 17-panel-layout.obj kernel32.lib
;

EXTERN ExitProcess:PROC

.code
    
main PROC
    sub rsp, 32
    xor rdi,rdi
    add rdi,12
    add rdi,12
    mov rax,60
    syscall

main ENDP
END
