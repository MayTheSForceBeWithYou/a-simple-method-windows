; Exercise 20: steering seek
;
; Seek desired vel = target-pos; (10-3)=7; exit 7.
;
; Build: ml64 /c 20-steering-seek.asm && link /OUT:20-steering-seek.exe /ENTRY:main /SUBSYSTEM:CONSOLE 20-steering-seek.obj kernel32.lib
;

EXTERN ExitProcess:PROC

.code
    
main PROC
    sub rsp, 32
    mov rdi,10
    sub rdi,3
    mov rax,60
    syscall

main ENDP
END
