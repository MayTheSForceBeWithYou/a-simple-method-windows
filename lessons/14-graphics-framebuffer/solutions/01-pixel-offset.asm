; Exercise 01: pixel offset
;
; offset=y*stride+x*4; y=2,x=3,stride=40; exit offset&255.
;
; Build: ml64 /c 01-pixel-offset.asm && link /OUT:01-pixel-offset.exe /ENTRY:main /SUBSYSTEM:CONSOLE 01-pixel-offset.obj kernel32.lib
;
; Expected exit: 92
; Expected stdout: (none)

EXTERN ExitProcess:PROC

.code
ex_01_pixel_offset PROC
    sub rsp, 40
    mov rax, 2
    imul rax, 40
    mov rbx, 3
    imul rbx, 4
    add rax, rbx
    and rax, 255
        mov     eax, rax
    ret

ex_01_pixel_offset ENDP
main PROC
    call    ex_01_pixel_offset
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
