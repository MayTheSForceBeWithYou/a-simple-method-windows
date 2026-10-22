; Exercise 18: mod via div
;
; Compute 42 % 5 using div; exit remainder 2.
;
; Build: ml64 /c 18-mod-via-div.asm && link /OUT:18-mod-via-div.exe /ENTRY:main /SUBSYSTEM:CONSOLE 18-mod-via-div.obj kernel32.lib
;
; Expected exit: 2

EXTERN ExitProcess:PROC

.code
ex_18_mod_via_div PROC
    sub rsp, 40
    mov rax, 42
    xor rdx, rdx
    mov rbx, 5
    div rbx
    mov rcx, rdx
    mov     eax, edx
    add     rsp, 40
    ret
ex_18_mod_via_div ENDP
main PROC
    sub     rsp, 40
    call    ex_18_mod_via_div
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
