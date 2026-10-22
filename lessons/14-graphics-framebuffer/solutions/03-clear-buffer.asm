; Exercise 03: clear buffer
;
; Clear 8 bytes to 0; exit first byte 0.
;
; Build: ml64 /c 03-clear-buffer.asm && link /OUT:03-clear-buffer.exe /ENTRY:main /SUBSYSTEM:CONSOLE 03-clear-buffer.obj kernel32.lib
;
; Expected exit: 0
; Expected stdout: (none)

EXTERN ExitProcess:PROC

.data?
fb BYTE 8 DUP(?)

.code
ex_03_clear_buffer PROC
    sub rsp, 40
    lea rdi, fb
    mov rcx, 8
    xor rax, rax
    rep stosb
    movzx rcx, BYTE PTR [fb]
    mov     eax, 0
    ret
    add     rsp, 40
ex_03_clear_buffer ENDP
main PROC
    call    ex_03_clear_buffer
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
