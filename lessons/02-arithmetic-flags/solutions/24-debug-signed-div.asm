; Exercise 24: debug signed div
;
; BUG: used xor rdx,rdx before idiv of negative. Fix with cqo. (-20)/3 quot -6.
;
; Build: ml64 /c 24-debug-signed-div.asm && link /OUT:24-debug-signed-div.exe /ENTRY:main /SUBSYSTEM:CONSOLE 24-debug-signed-div.obj kernel32.lib
;
; Expected exit: 0

EXTERN ExitProcess:PROC

.code
ex_24_debug_signed_div PROC
    sub rsp, 40
    mov rax, -20
    cqo
    mov rbx, 3
    idiv rbx
    mov rcx, rax
    add rcx, 6
    mov     eax, ecx
    add     rsp, 40
    ret
ex_24_debug_signed_div ENDP
main PROC
    sub     rsp, 40
    call    ex_24_debug_signed_div
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
