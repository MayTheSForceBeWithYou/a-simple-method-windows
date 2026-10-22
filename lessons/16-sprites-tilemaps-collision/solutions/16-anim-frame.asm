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
ex_16_anim_frame PROC
    sub rsp, 40
    mov rax, 10
    xor rdx, rdx
    mov rbx, 4
    div rbx
    xor rdx, rdx
    mov rbx, 3
    div rbx
    call ExitProcess
    mov     eax, edx
    add     rsp, 40
    ret
ex_16_anim_frame ENDP
main PROC
    sub     rsp, 40
    call    ex_16_anim_frame
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
