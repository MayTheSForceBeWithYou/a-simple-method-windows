; Listing 04: Tile map grid in BSS (LESSON.md block 4)
; Expected exit: 0
; Expected stdout: (none)

grid_w EQU 8
grid_h EQU 8

.DATA?
tilemap DB 64 DUP(?)

.CODE
EXTRN ExitProcess:PROC

main PROC
    sub rsp, 40
    xor     ecx, ecx
    call    ExitProcess
main ENDP
END
