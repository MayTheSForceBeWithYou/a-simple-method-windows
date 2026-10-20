; Exercise 20: clamp
;
; x=150. Clamp to [0,100]. Exit 100.
;
; Build: ml64 /c 20-clamp.asm && link /OUT:20-clamp.exe /ENTRY:main /SUBSYSTEM:CONSOLE 20-clamp.obj kernel32.lib
;
; Expected exit: 100

EXTERN ExitProcess:PROC

.code
main PROC
    sub rsp, 32
    mov rax, 150
    cmp rax, 0
    jge hi
    xor rax, rax
hi:
    cmp rax, 100
    jle ok
    mov rax, 100
ok:
    mov rcx, rax
    call ExitProcess
main ENDP
END
