; Exercise 04: imul two
;
; imul-style: rax=6, imul rax,7; mov rcx,rax; exit 42.
;
; Build: ml64 /c 04-imul-two.asm && link /OUT:04-imul-two.exe /ENTRY:main /SUBSYSTEM:CONSOLE 04-imul-two.obj kernel32.lib
;
; Expected exit: 42

EXTERN ExitProcess:PROC

.code
main PROC
    sub rsp, 32
    mov rax, 6
    imul rax, 7
    mov rcx, rax
    call ExitProcess
main ENDP
END
