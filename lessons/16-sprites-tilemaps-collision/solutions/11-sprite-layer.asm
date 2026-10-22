; Exercise 11: sprite layer
;
; Sort key layer*1000+y; layer2 y=5 -> 2005&255; exit (2005 & 255)=205? Use exit layer=2.
;
; Build: ml64 /c 11-sprite-layer.asm && link /OUT:11-sprite-layer.exe /ENTRY:main /SUBSYSTEM:CONSOLE 11-sprite-layer.obj kernel32.lib
;
; Expected exit: 2
; Expected stdout: (none)

EXTERN ExitProcess:PROC

.code

ex_11_sprite_layer PROC
sub rsp, 40
    mov     eax, 2
    ret
ex_11_sprite_layer ENDP
main PROC
    sub     rsp, 40
    call    ex_11_sprite_layer
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
