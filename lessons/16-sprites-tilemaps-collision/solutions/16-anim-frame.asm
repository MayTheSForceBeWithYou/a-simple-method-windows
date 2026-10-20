; Exercise 16: anim frame
;
; frame = (t/ticks)%n; t=10 ticks=4 n=3 -> 2; exit 2.
;
; Build: ml64 /c 16-anim-frame.asm && link /OUT:16-anim-frame.exe /ENTRY:main /SUBSYSTEM:CONSOLE 16-anim-frame.obj kernel32.lib
;
; Expected exit: 2
; Expected stdout: (none)

EXTERN ExitProcess:PROC

.code
main PROC
    sub rsp, 32
    mov rax, 10
    xor rdx, rdx
    mov rbx, 4
    div rbx
    xor rdx, rdx
    mov rbx, 3
    div rbx
    mov rcx, rdx
    call ExitProcess
main ENDP
END
