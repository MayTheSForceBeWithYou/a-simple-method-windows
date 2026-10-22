; Exercise 14: tile collision mask
;
; Flags bit0 solid bit1 platform; value 3; exit solid&1 =1.
;
; Build: ml64 /c 14-tile-collision-mask.asm && link /OUT:14-tile-collision-mask.exe /ENTRY:main /SUBSYSTEM:CONSOLE 14-tile-collision-mask.obj kernel32.lib
;
; Expected exit: 1
; Expected stdout: (none)

EXTERN ExitProcess:PROC

.data
flags BYTE 3

.code

ex_14_tile_collision_mask PROC
sub rsp, 40
    movzx rcx, BYTE PTR [flags]
    and rcx, 1
    mov     eax, 1
    ret
ex_14_tile_collision_mask ENDP
main PROC
    sub     rsp, 40
    call    ex_14_tile_collision_mask
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
