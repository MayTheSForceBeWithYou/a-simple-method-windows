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
main PROC
    sub rsp, 32
    lea rdi, fb
    mov rcx, 8
    xor rax, rax
    rep stosb
    movzx rcx, BYTE PTR [fb]
    call ExitProcess
main ENDP
END
