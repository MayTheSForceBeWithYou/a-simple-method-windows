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
main PROC
    sub rsp, 40
    mov rax, 20
    shr rax, 3
    mov rcx, rax
    call ExitProcess
main ENDP
END
