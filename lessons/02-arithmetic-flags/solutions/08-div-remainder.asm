; Exercise 08: div remainder
;
; Unsigned: 20 / 6. Exit with remainder (rdx) = 2.
;
; Build: ml64 /c 08-div-remainder.asm && link /OUT:08-div-remainder.exe /ENTRY:main /SUBSYSTEM:CONSOLE 08-div-remainder.obj kernel32.lib
;
; Expected exit: 2

EXTERN ExitProcess:PROC

.code
ex_08_div_remainder PROC
    sub rsp, 40
    mov rax, 20
    xor rdx, rdx
    mov rbx, 6
    div rbx
        mov     eax, rdx
    add     rsp, 40
    ret
ex_08_div_remainder ENDP
main PROC
    call    ex_08_div_remainder
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
