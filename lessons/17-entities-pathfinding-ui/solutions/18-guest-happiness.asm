; Exercise 18: guest happiness
;
; Clamp happiness add 20 from 90 -> 100; exit 100.
;
; Build: ml64 /c 18-guest-happiness.asm && link /OUT:18-guest-happiness.exe /ENTRY:main /SUBSYSTEM:CONSOLE 18-guest-happiness.obj kernel32.lib
;

EXTERN ExitProcess:PROC

.code
    
main PROC
    sub rsp, 32
    mov rax,90
    add rax,20
    cmp rax,100
    jle .ok
    mov rax,100
.ok:
    mov rcx, rax
    call ExitProcess

main ENDP
END
