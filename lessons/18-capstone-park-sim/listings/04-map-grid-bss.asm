; Listing 04: Tile map grid in BSS (LESSON.md block 4)
; Expected exit: 0
; Expected stdout: (none)

width EQU 8
height EQU 8

.DATA?
map DB 64 DUP(?)

.CODE
EXTRN ExitProcess:PROC

main PROC
    sub rsp, 40
    xor     ecx, ecx
    call    ExitProcess
main ENDP
END
