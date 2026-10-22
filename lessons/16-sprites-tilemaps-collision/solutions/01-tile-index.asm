; Exercise 01: tile index
;
; idx=y*map_w+x; y=2 x=3 w=10; exit 23.
;
; Build: ml64 /c 01-tile-index.asm && link /OUT:01-tile-index.exe /ENTRY:main /SUBSYSTEM:CONSOLE 01-tile-index.obj kernel32.lib
;
; Expected exit: 23
; Expected stdout: (none)

EXTERN ExitProcess:PROC

.code
ex_01_tile_index PROC
    sub rsp, 40
    mov rax, 2
    imul rax, 10
    add rax, 3
    mov rcx, rax
    mov     eax, eax
    add     rsp, 40
    ret
ex_01_tile_index ENDP
main PROC
    sub     rsp, 40
    call    ex_01_tile_index
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
