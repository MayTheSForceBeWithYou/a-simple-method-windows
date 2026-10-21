; Exercise 14: debug div rdx
;
; BUG: forgot xor rdx,rdx before div. Fix; 100/10 quot exit 10.
;
; Build: ml64 /c 14-debug-div-rdx.asm && link /OUT:14-debug-div-rdx.exe /ENTRY:main /SUBSYSTEM:CONSOLE 14-debug-div-rdx.obj kernel32.lib
;
; Expected exit: 10

EXTERN ExitProcess:PROC

.code
main PROC
    sub rsp, 40
    mov rax, 100
    xor rdx, rdx
    mov rbx, 10
    div rbx
    mov rcx, rax
    call ExitProcess
main ENDP
END
