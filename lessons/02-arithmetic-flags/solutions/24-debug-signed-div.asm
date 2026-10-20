; Exercise 24: debug signed div
;
; BUG: used xor rdx,rdx before idiv of negative. Fix with cqo. (-20)/3 quot -6.
;
; Build: ml64 /c 24-debug-signed-div.asm && link /OUT:24-debug-signed-div.exe /ENTRY:main /SUBSYSTEM:CONSOLE 24-debug-signed-div.obj kernel32.lib
;
; Expected exit: 0

EXTERN ExitProcess:PROC

.code
main PROC
    sub rsp, 32
    mov rax, -20
    cqo
    mov rbx, 3
    idiv rbx
    mov rcx, rax
    add rcx, 6
    call ExitProcess
main ENDP
END
