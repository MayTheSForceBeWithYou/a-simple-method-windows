; Exercise 09: map place path
;
; Place PATH=1 at (2,3) on w=8; index=3*8+2=26; store; exit cell.
;
; Build: ml64 /c 09-map-place-path.asm && link /OUT:09-map-place-path.exe /ENTRY:main /SUBSYSTEM:CONSOLE 09-map-place-path.obj kernel32.lib
;

EXTERN ExitProcess:PROC

.code
    
main PROC
    sub rsp, 32
    mov rax,3
    imul rax,8
    add rax,2
    mov byte [map+rax],PATH
    movzx rdi,byte [map+rax]
    mov rax,60
    syscall

main ENDP
END
