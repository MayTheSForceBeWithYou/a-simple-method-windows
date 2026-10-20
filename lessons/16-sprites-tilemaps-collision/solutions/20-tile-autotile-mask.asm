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
main PROC
    sub rsp, 32
    mov rcx, N
    or rcx, E
    call ExitProcess
main ENDP
END
