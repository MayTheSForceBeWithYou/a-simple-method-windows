; Exercise 01: pixel offset
;
; offset=y*stride+x*4; y=2,x=3,stride=40; exit offset&255.
;
; Build: ml64 /c 01-pixel-offset.asm && link /OUT:01-pixel-offset.exe /ENTRY:main /SUBSYSTEM:CONSOLE 01-pixel-offset.obj kernel32.lib
;
; Expected exit: 88
; Expected stdout: (none)

EXTERN ExitProcess:PROC

.code
main PROC
    sub rsp, 32
    mov rax, 2
    imul rax, 40
    mov rbx, 3
    imul rbx, 4
    add rax, rbx
    and rax, 255
    mov rcx, rax
    call ExitProcess
main ENDP
END
