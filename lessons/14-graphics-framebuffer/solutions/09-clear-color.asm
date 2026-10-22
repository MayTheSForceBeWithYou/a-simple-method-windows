; Exercise 09: clear color
;
; Clear 4 pixels to color 5; exit first.
;
; Build: ml64 /c 09-clear-color.asm && link /OUT:09-clear-color.exe /ENTRY:main /SUBSYSTEM:CONSOLE 09-clear-color.obj kernel32.lib
;
; Expected exit: 5
; Expected stdout: (none)

EXTERN ExitProcess:PROC

.data?
fb BYTE 4 DUP(?)

.code
ex_09_clear_color PROC
    sub rsp, 40
    mov al, 5
    lea rdi, fb
    mov rcx, 4
    rep stosb
    movzx rcx, BYTE PTR [fb]
    mov     eax, 5
    ret
ex_09_clear_color ENDP
main PROC
    call    ex_09_clear_color
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
