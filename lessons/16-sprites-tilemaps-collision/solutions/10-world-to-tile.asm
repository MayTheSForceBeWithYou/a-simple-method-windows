; Exercise 10: world to tile
;
; world x=20 tile_size=8 -> tile 2; exit 2.
;
; Build: ml64 /c 10-world-to-tile.asm && link /OUT:10-world-to-tile.exe /ENTRY:main /SUBSYSTEM:CONSOLE 10-world-to-tile.obj kernel32.lib
;
; Expected exit: 2
; Expected stdout: (none)

EXTERN ExitProcess:PROC

.code

ex_10_world_to_tile PROC
mov rax, 20
    shr rax, 3
    mov rcx, rax

    ret
ex_10_world_to_tile ENDP
main PROC
    sub     rsp, 40
    call    ex_10_world_to_tile
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
