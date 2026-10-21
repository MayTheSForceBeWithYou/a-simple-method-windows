; Exercise 18: mod via div
;
; Compute 42 % 5 using div; exit remainder 2.
;
; Build: ml64 /c 18-mod-via-div.asm && link /OUT:18-mod-via-div.exe /ENTRY:main /SUBSYSTEM:CONSOLE 18-mod-via-div.obj kernel32.lib
;
; Expected exit: 2

EXTERN ExitProcess:PROC

.code
main PROC
    sub rsp, 40
    mov rax, 42
    xor rdx, rdx
    mov rbx, 5
    div rbx
    mov rcx, rdx
    call ExitProcess
main ENDP
END
