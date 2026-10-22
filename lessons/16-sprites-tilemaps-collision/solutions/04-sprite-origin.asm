; Exercise 04: sprite origin
;
; screen = world - camera; 50-20=30.
;
; Build: ml64 /c 04-sprite-origin.asm && link /OUT:04-sprite-origin.exe /ENTRY:main /SUBSYSTEM:CONSOLE 04-sprite-origin.obj kernel32.lib
;
; Expected exit: 30
; Expected stdout: (none)

EXTERN ExitProcess:PROC

.code
ex_04_sprite_origin PROC
    sub rsp, 40
    mov rcx, 50
    sub rcx, 20
    mov     eax, 30
    add     rsp, 40
    ret
ex_04_sprite_origin ENDP
main PROC
    sub     rsp, 40
    call    ex_04_sprite_origin
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
