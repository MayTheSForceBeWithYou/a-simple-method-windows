; Exercise 16: ui focus
;
; Tab cycles focus index mod 3; from 2 -> 0; exit 0.
;
; Build: ml64 /c 16-ui-focus.asm && link /OUT:16-ui-focus.exe /ENTRY:main /SUBSYSTEM:CONSOLE 16-ui-focus.obj kernel32.lib
;

EXTERN ExitProcess:PROC

.code
    
main PROC
    sub rsp, 32
    mov qword [focus],2
    inc qword [focus]
    mov rax,[focus]
    xor rdx,rdx
    mov rbx,3
    div rbx
    mov [focus],rdx
    mov rcx, rdx
    call ExitProcess

main ENDP
END
