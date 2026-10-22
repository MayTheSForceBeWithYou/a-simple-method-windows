; Exercise 04: imul two
;
; imul-style: rax=6, imul rax,7; mov rcx,rax; exit 42.
;
; Build: ml64 /c 04-imul-two.asm && link /OUT:04-imul-two.exe /ENTRY:main /SUBSYSTEM:CONSOLE 04-imul-two.obj kernel32.lib
;
; Expected exit: 42

EXTERN ExitProcess:PROC

.code
ex_04_imul_two PROC
    sub rsp, 40
    mov rax, 6
    imul rax, 7
        mov     eax, rax
    ret

ex_04_imul_two ENDP
main PROC
    call    ex_04_imul_two
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
