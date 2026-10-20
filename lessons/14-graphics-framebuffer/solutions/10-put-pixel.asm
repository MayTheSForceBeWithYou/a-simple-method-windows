; Exercise 10: put pixel
;
; put_pixel(x,y) with stride 8 bpp1; x=2 y=1 -> offset 10; store 9; exit 9.
;
; Build: ml64 /c 10-put-pixel.asm && link /OUT:10-put-pixel.exe /ENTRY:main /SUBSYSTEM:CONSOLE 10-put-pixel.obj kernel32.lib
;
; Expected exit: 9
; Expected stdout: (none)

EXTERN ExitProcess:PROC

.data?
fb BYTE 32 DUP(?)

.code
main PROC
    sub rsp, 32
    mov rax, 1
    imul rax, 8
    add rax, 2
    mov BYTE PTR [fb+rax], 9
    movzx rcx, BYTE PTR [fb+rax]
    call ExitProcess
main ENDP
END
