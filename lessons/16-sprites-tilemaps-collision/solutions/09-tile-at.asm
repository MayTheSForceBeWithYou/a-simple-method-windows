; Exercise 09: tile at
;
; map 4-wide; get(1,1)= tile index 5 stored; exit 5.
;
; Build: ml64 /c 09-tile-at.asm && link /OUT:09-tile-at.exe /ENTRY:main /SUBSYSTEM:CONSOLE 09-tile-at.obj kernel32.lib
;
; Expected exit: 5
; Expected stdout: (none)

EXTERN ExitProcess:PROC

.data
map BYTE 0,1,2,3, 4,5,6,7

.code
main PROC
    sub rsp, 40
    mov rax, 1
    imul rax, 4
    add rax, 1
    lea r11, [map]
    movzx rcx, BYTE PTR [r11+rax]
    call ExitProcess
main ENDP
END
