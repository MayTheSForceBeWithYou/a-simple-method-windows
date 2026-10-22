; Exercise 05: tile solid
;
; tile id 2 solid table; exit 1.
;
; Build: ml64 /c 05-tile-solid.asm && link /OUT:05-tile-solid.exe /ENTRY:main /SUBSYSTEM:CONSOLE 05-tile-solid.obj kernel32.lib
;
; Expected exit: 1
; Expected stdout: (none)

EXTERN ExitProcess:PROC

.data
solid BYTE 0,0,1,0

.code
ex_05_tile_solid PROC
    sub rsp, 40
    movzx rcx, BYTE PTR [solid+2]
    mov     eax, ecx
    add     rsp, 40
    ret
ex_05_tile_solid ENDP
main PROC
    sub     rsp, 40
    call    ex_05_tile_solid
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
