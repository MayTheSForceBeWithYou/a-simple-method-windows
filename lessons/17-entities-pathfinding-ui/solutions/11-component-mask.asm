; Exercise 11: component mask
;
; Has POS|VEL = 3; exit 3.
;
; Build: ml64 /c 11-component-mask.asm && link /OUT:11-component-mask.exe /ENTRY:main /SUBSYSTEM:CONSOLE 11-component-mask.obj kernel32.lib
;

EXTERN ExitProcess:PROC

.code
    
main PROC
    sub rsp, 32
    mov rdi,POS
    or rdi,VEL
    mov rax,60
    syscall

main ENDP
END
