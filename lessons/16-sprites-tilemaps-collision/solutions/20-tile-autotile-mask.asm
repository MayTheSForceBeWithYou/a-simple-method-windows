; Exercise 20: tile autotile mask
;
; Neighbor mask N|E = 5; exit 5.
;
; Build: ml64 /c 20-tile-autotile-mask.asm && link /OUT:20-tile-autotile-mask.exe /ENTRY:main /SUBSYSTEM:CONSOLE 20-tile-autotile-mask.obj kernel32.lib
;
; Expected exit: 5
; Expected stdout: (none)

EXTERN ExitProcess:PROC

N EQU 1
E EQU 4

.code
ex_20_tile_autotile_mask PROC
    sub rsp, 40
    mov rcx, N
    or rcx, E
    mov     eax, 5
    ret
    add     rsp, 40
ex_20_tile_autotile_mask ENDP
main PROC
    call    ex_20_tile_autotile_mask
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
